import React, { useState } from 'react'
import { Platform, StyleSheet, SafeAreaView, StatusBar, Text } from 'react-native'
import Constants from 'expo-constants'

import Focus from './src/features/Focus'
import FocusHistory from './src/features/FocusHistory'
import Timer from './src/features/Timer'

import { colors } from './src/utils/colors'
import { focusHistory } from './src/utils/fixtures'


export default function App({ /* container, */ text } = styles) {

    const [subject, setSubject] = useState('')
    const [history, setHistory] = useState(focusHistory)

    return (
        <SafeAreaView style={styles.container}>
            
            {/*
            <Text style={text}>.</Text>
            <StatusBar style="auto" />
            */}

            {
            !subject
            ? (
                <Focus addSubject={setSubject} />,
                <FocusHistory history={history} />
            ) : // <View>
                <Timer
                    focusSubject={subject}
                    clearSubject={() => setSubject('')}
                    onTimerEnd={subject => setHistory([...focusHistory, subject])} // confirm subject !== state subject
                    />
            // </View>
            }

            
            
        </SafeAreaView>
    )
}

const styles = StyleSheet.create({
    container: {
        paddingTop: Platform.OS === 'android' ? StatusBar.currentHeight : 0,
        backgroundColor: colors.darkBlue,
        flex: 1
    },
    text: {
        color: colors.white
    }
})