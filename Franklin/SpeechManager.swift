//
//  SpeechManager.swift
//  Franklin
//
//  Created by Sergio Puleri on 3/6/17.
//  Copyright © 2017 Franklin. All rights reserved.
//

import Foundation
import Speech


class SpeechManager: NSObject, SFSpeechRecognizerDelegate {
    // Singleton instance, so we don't need to bother passing it around through view controllers
    static let sharedInstance = SpeechManager()

    // Speech recognizer
    private var speechRecognizer: SFSpeechRecognizer?
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    // Bus number to install a tap on the inputNode on. This allows us to listen on the audio stream from the input device (mic)
    let BUS_NUM = 0
    
    var inputDelegate: InputManagerDelegate?
    
    private override init() {
        super.init()
        
        // Initialize recognizer to english
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
        
        // Set Delegate
        speechRecognizer?.delegate = self
    }
    
    func requestMicAccess() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                print("We're good to go")
                
            case .denied:
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
        }
    }
    
    // Called by the view controller on each new step to stop/start session
    func startRecordingSesion() {
        if audioEngine.isRunning {
            print("audioEngine is running when attemping to start recording.")
        }
        
        stopProcessing()
        
        startRecording()
        // Denote we are listening
        inputDelegate?.setIsReadyForInput(isReady: true)
        
    }
    
    func stopRecordingSession() {
        stopProcessing()
    }
    
    private func stopProcessing() {
        if let inputNode = audioEngine.inputNode {
            inputNode.removeTap(onBus: self.BUS_NUM)
        }
        
        self.audioEngine.stop()
        
        recognitionRequest?.endAudio()
        self.recognitionTask?.cancel()
        self.recognitionRequest = nil
        self.recognitionTask = nil
    }
    
    // Recording and Speech Transcribing Logic
    private func startRecording() {
        // Cancel an inprogress recognition task
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        // New recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        
        // Unwrap all the optional objects hehe
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        guard let speechRecognizer = speechRecognizer else {
            fatalError("Unable to create an SFSpeechRecognizer object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        // Start the recognition task
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var commandHandler: (() -> ())? = nil
            
            if let result = result {
                let spokenText = result.bestTranscription.formattedString
                print("Got some words:\n\(spokenText)\n\n")
                
                commandHandler = self.processUsersAnswer(spokenText: spokenText)
                // If we get some text and it is a valid 'left' 'right' 'up' or 'down', stop this recording session
            }
            
            // If there was an error recognizing the voice OR this transcription is final, stop recording for now
            if error != nil || commandHandler != nil {
                if let error = error {
                    // See: https://forums.developer.apple.com/thread/73256
                    print("Got an error processing speech... We should be gucci tho!\n\(error)\n")
                }
                
                if let handler = commandHandler {
                    // Show case something on the screen to denote if recording or not
                    self.inputDelegate?.setIsReadyForInput(isReady: false)
                    handler()
                }
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: BUS_NUM)
        inputNode.installTap(onBus: BUS_NUM, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        // Update view to denote listening
        self.inputDelegate?.setIsReadyForInput(isReady: true)
        print("Say something, I'm listening!")        
    }
    

    // Processes text looking for a valid phrase
    // Returns an optional closure to execute to notify the ExamViewController if found a valid phrase command
    // Else returns nil.
    // A closure is returned instead of just calling the function because we need to check if a valid phrase was found
    // To stop recording. THEN notify the ExamViewController of this command. Which will then progress the test to the next step.
    
    // TODO: If multiple phrases are found, take the last one
    private func processUsersAnswer(spokenText: String) -> (() -> ())? {
        // Lowercase the transcribed text
        let lowerCase = spokenText.lowercased()
        
        // Process  with string searching
        if lowerCase.contains("left") {
            print("Parsed left from speech")
            
            return {
                self.inputDelegate?.left()
            }
        }
        else if lowerCase.contains("right") {
            print("Parsed right from speech")
            
            return {
                self.inputDelegate?.right()
            }
        }
        else if lowerCase.contains("up") {
            print("Parsed up from speech")
            
            return {
                self.inputDelegate?.up()
            }
        }
        else if lowerCase.contains("down") {
            print("Parsed down from speech")
            
            return {
                self.inputDelegate?.down()
            }
        }
        // TODO: Configure with more 'unsure' phrases if necessary
        else if lowerCase.contains("i don't know") ||
            lowerCase.contains("not sure") ||
            lowerCase.contains("unsure") ||
            lowerCase.contains("no"){
            
            print("Parsed unsure from speech")
            return {
                self.inputDelegate?.unsure()
            }
            
        } else {
            print("Got no valid commands from speech")
            return nil
        }
    }
    
    // MARK: SFSpeechRecognizerDelegate
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            // TODO: Alert VC that we are good to go
        } else {
            // TODO: Alert VC that we are NOT good to go, stop exam
        }
    }
}
