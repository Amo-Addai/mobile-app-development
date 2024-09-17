import React from 'react'
import { StyleSheet, View, Text } from 'react-native'
import { StatusBar } from 'expo-status-bar'


export default function App() {

    return (
        <View style={styles.container}>
            
            <Text>.</Text>
            <StatusBar style="auto" />

        </View>
    )
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff'
    }
})