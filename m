Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B7D2D1EBA
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 01:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgLHABr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 19:01:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:48449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgLHABr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 19:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607385603;
        bh=wvtwafmRpa5o7FnknQH0FLf14PhWObhwf1sB2Xashig=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bAYgifTVJ7vR2Ea2fItrfoK1BZS+/ht27lJjLRVNR5iAXHRY/M5StKlyDhimYcdO6
         6hsUaNJQmbiR6goMzQSzDM/9bW2Qe5RYGo1vrnyPbSBvefLyVgla8KGzAbSEwZBbok
         tDhVEJ5VVsPq7liNSzyO1YZ0pAC7Le+1/gbEvSMY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1k8fqt11vc-014E2I; Tue, 08
 Dec 2020 01:00:03 +0100
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sean Young <sean@mess.org>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
 <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
 <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
 <20201205173444.GA1265@gofer.mess.org>
 <20201205192510.o76pjs3yc524nwvm@pengutronix.de>
 <20201206141941.GA24807@gofer.mess.org>
 <20201207081628.tm3yg7az5k5sbivu@pengutronix.de>
 <20201207094320.GA10460@gofer.mess.org>
 <20201207135209.htp7plyotjxp37q2@pengutronix.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <ad83f03b-869d-44e1-5db9-d5e91a0c0da3@gmx.de>
Date:   Tue, 8 Dec 2020 01:00:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207135209.htp7plyotjxp37q2@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9LTnKuUWkzb+9t5TXmpWktlN8X27SbL8PRv/wO+Yb/T2Ncr1Oh7
 ROYMUo89lqZYg5T43iSExDPBF99psOQzkqsSKHvW30QRSmBpgODTqfLzELAD3LMW5HcqWeA
 7+qSN3osa06fkvygaa1zQg7Dzg8ziHJ8URrmaIeGRgoif3k4Hw5w+l6245cFpzYDVtFz6n8
 NExj7xIsO0UWwzJ+TgmlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qn4Zb7/VqAU=:SKP1eIFfNnl30EvA80MARf
 QqFrADljiJpGWQ7mnIqKI7R9tvbrMjHF5yeMZUeXlt91i4RACGzahV9v2IdXc/VZoUyfu+ajo
 oujMvUsg+deWlVTY7Livpe4PU7DxZEK9g19M/gCrbU1GJDHOM8i8UQrAOcOqfvgIheeb2pPNw
 CYlQ2x0YOEPUur4Sx5OZ9l6frviE0xzNrCXF0ADVZp7qBBLWGL7lw6SyzJZ+RZwb+cA7mSuYl
 v/9jbiwF9G5vQ0BCOwWJhqtwB0M9mWef8DDz44RZIlvBDZeXIiWV0KW3fKXVkM1coy+oPGmMF
 azCmkbA1cLB9oEG1Noqyq3azlkEY0u47cq6hlCt0jWLspYKKnan1b9srOUtUPRwf/PFE8tjC/
 4mPZLTAUOB0erDLdL18qrqN60GPegVNrmeJRkMibhj6rmUMxfz/ktPrvfC6tSBLiuK8LqKh6p
 SOO2u4B4p4NCgZKkVQOvjOlsHZvkaI6F2ixjHZ8i1q5Fb3qIjLN46geBw8yXQ//RiMuHQAws/
 COqVNXPgoAOEJFxRcgNilOYcjBTZZZyC0qcGX0nYPUuU7KDRZ18aJXL/AnYhlTtLtRtPdIf5J
 WZEjIs3KFplP6xF8kzhJatgljXSBwQBDBEVS3QpTHEyqDKicSGZv/bMOoczqoRSakOVLsgwKi
 anrsfPlQJsqnimAv3PPy5I48f9uurlEr0qgurcgPVQAP+qtML9siyWFg19ic1jb1k65kQzkfB
 gb5+1U1VIN+GkTVyORDAR7TTmM84uSmV7syo0mBcJes6/jGAEqniNxrMILypd92CYVE9W6vkQ
 snAk9IZYuHzRzLIhxiuIcQHSrdfcUp1obv2j+uc9//vTfYAWsWJD//dliTTuY8egTnhLEc6cG
 IhNsYqG5vRrTzeakTAmw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 07.12.20 at 14:52, Uwe Kleine-K=F6nig wrote:

>
> Given that the bcm2835 driver is quite trivial I would be happy to
> create a series that "fixes" the driver to round down and provide a
> prototype for pwm_round_nearest for you to test on pwm-ir-tx. A willing
> tester and a real use-case were the single two things that stopped me
> investing time here.
>

Should I send a v3 of the .apply() support for the bcm2835 driver before y=
ou start
such a rework? The v3 would contain the check against truncation of the pe=
riod but
keep the round-closest strategy as it is.

Regards,
Lino

