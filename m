Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6F7276CDC
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 11:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgIXJNK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 05:13:10 -0400
Received: from sonic305-20.consmr.mail.ne1.yahoo.com ([66.163.185.146]:41798
        "EHLO sonic305-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbgIXJNK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Sep 2020 05:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600938789; bh=zXaFIo8mjTpXao4VNtylOhTc/LqLzQin3ncX1bFuSgM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Wbij67I+niH9yGjjMFHy5sB+yAYrOvCkNRBIdb7QQCOI6/d3USpjn5j33y7UpKzv0zH7l8QArF00iRyoaW9fLtoTXDEvSvp7qmscjm17MgZZW0t8/1cnRwQW+2HqfCtgtB5il2Rv25wCd3qSbrbrZRWLTUyP7tjUceZTRFCstmffN5uLgidezyha8cckUL/gELU4S65AKqKv8+a1CcQM5+805plO4PH9EUvD8kgOG4SC6+rPQ9HwERDs2TdSo+hFE5hpLAm2DSmRDToMoE41IqrKX5cqNOpIhPLV7BrpcXMVsDSsQ0dKa+rUpUUHhMrEmqIL5EtBUgzMP6e/VtRYGQ==
X-YMail-OSG: DjSIguMVM1lKu24VNzD8syJfSdkmrW9S0pIMJsUOVd6xMIYs41sfF50CJcwXze4
 a2ARJeN7OJ_jY0JdyZzBxBfH4tC2vP91xdHQEPRU6cqyK_l8l.pZ3RQbAc6UCtADdNsvBwyt7hUo
 v94FdaAYjti5y2ZktezLDI9T4Ol.87D9Slnb1jiIhyVZT29VIHZR0uHrTSi.WNRYEomLpGtS7eba
 RXtsm0GehAFEgN5ZpZmQnMW21SbRAkZkfEks4ZWzJrLlAZZXPgcJjbfee68IusSqjNNb2bBka3bx
 esQkOGFidkRUt.8VEMbcf0JCrw80jutsEmJgPNtqFmF_mOuEvMYEbocIWLC3IQfFcM0AapUA3lQ.
 yatfUu5os2.2rnpSL7qpE8y6cC73.lDskwMXKEfx3Ex0YjZy2844ZS3eCZn.6A2RVfFSzaS3kFoK
 OXJjSccug6aK0uFZyuMEG3DOKf02qVFA.5IfDk3BDg7AIUGz5PbS1FTfUo7WKR1qziJOWpWd9RdW
 gqm3dxSFudNZp.tC_N0lkRgy2tAIZ3tRMXiQy1Y0BsVH7ThnDmv2R8yl3yhI7T_zo7p7Du5rYONk
 g47qX0oXH_SBYkICv6krQq3m.JJKl8qUrzrQT.Y4Y1ejMMmGfQoTcaHarORonJx1KW40WmyGyN9Z
 1LlWcIytbHoQ_wSD6BloBivHROqUJ2WBMYxJRZF_yTJVMaomdmXTiw_38qAvTuRxyAnR6jwo_2f7
 2wTp1OMmpQOaMz52Fs1H1p5yQHuNdQXIW3w6lU1tNjtMwXLHg2FsHr89JRaHTUttu3V44d3vTsay
 pa40KfAEVT1gt8fqE4GL5r0_8ud_lUO4zipYXuYaR2_JHixWpSc35h7Wwyqz9G3sbLxwmSk_q30.
 garTNKmqPXx4crIJVaUzrnWQdvrm7omG1kzKEoDja_WYs07jD6H89jsCwSJGFz7uvD_xi85aOz2m
 1nSC3Ryuw7320AoybBsDyFUg1RhHIUm5u9F4LE2m9CL3u5DOGAfo3k7TVbjxoy9pTlWYg.PFQDFJ
 UL5qi.caeThuxPr8VmPTULP_h3VOkEv4PAkVbu.UqwFzEvUDHIqEmuEXy9uaKizyCvtR2KhOBLk8
 rKYFIEC1gGRD_4qYbJHFKkXQBMANBMtBx5KLn5bIEGKOAWCyvTbEpkevV9eenAqclECZqajrzFb1
 Rvt9k7LgD8iDVkinFeVgf0cwDKEtRlA3J1UEkM0xafDort2Q2uHKASbahcyQo1f8TgNMcyvJAyBb
 BDITGUCGajRfdPvRF5oFZzJ4W6.G.wbO2lje_cFVV14WGVX5aLcYBGDkzL8kDai0QuthFzYmjpyu
 utUpL7qojkLVgKwYjrpiCsusjGK_iBkwcXv.4uS6aY0MKrZmXPH4E4sIfYie4Wc64UHyXkyJaPn.
 3_L4C_oZdwgpX7pL4_YohoVk9bk87O_b1LkIo6rB0_KiKp4yTGXkc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Sep 2020 09:13:09 +0000
Date:   Thu, 24 Sep 2020 09:13:06 +0000 (UTC)
From:   Kuban Manfi <nolanbraten4@gmail.com>
Reply-To: fadiansi55@gmail.com
Message-ID: <1603299959.243129.1600938786542@mail.yahoo.com>
Subject: VERY CONFIDENTIAL.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1603299959.243129.1600938786542.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Compliment of the season,

My names are Mr. Kuban Manfi, i work a department manager in one of the reputable banks here in Africa.

I have a lucrative and profitable business which i would like to introduce to you. Please this is very confidential and if you are interested kindly get back to me for more details.

Thanks
Mr.Kuban Manfi
