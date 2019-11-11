Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E0F74D0
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 14:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKKN3B (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 08:29:01 -0500
Received: from mout.web.de ([217.72.192.78]:43447 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfKKN3B (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Nov 2019 08:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573478933;
        bh=9i5xRqQw02PIr0vo9cbpgB28RyeG9nFcczIEk1OQyv8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QOpehSSSQwP/4Hy3WF76GJEVuD6RGeUchrQ13QuRNeCQD196t/rBPNmoYBXlQrv6M
         X2lZZ1g16zRM2jlxxI1wUlSKY+NwIaeJ84/ZnTWjDWkrkpXbPQkXv82qPidPKCe23H
         PKmZcvOAsyLbCdzk3GiFJDUv573FXBKNVAtEgFU8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.55.229]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyDlZ-1hrRR21WhJ-015ZHr; Mon, 11
 Nov 2019 14:28:53 +0100
Subject: Re: [0/4] pwm: omap-dmtimer: Software improvements
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Brown <neilb@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        kernel@pengutronix.de, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111091606.qf7gj5gln3khfnsl@pengutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3672014f-14f2-7568-8258-bc472f3b9ae1@web.de>
Date:   Mon, 11 Nov 2019 14:28:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111091606.qf7gj5gln3khfnsl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xSTvbwzjapXnF/XBMPQTAcTrEJ1YInrQe01BSlUtomJLo6ck6Hq
 +n7vwuR/O4p2zg5jBJ8cUEyFhjlmF86TCWFtxmVCZqF3osw2jbe2lj34G3y7z+/05uvFQ+f
 oLxIdfTUfoEA+o9QTgLwU5wiu518XWYRIuZVv/AZbo0WdjZsaZlMXvkZM4xVb6HXlin3dHL
 dN8x8d/8AtEfGPDFrZ8hw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YMsbmDf2bAQ=:fXHoLKtMFBDzbZiND/uis9
 /neHu7efWXujHhaeYEyJ7GcOP5zPAOqWKqTWSgZnefViBy9KU7c7dAWbYW8Isj2SD4miFVbc6
 BpxMsmHAWRPMRUGolS+BlZ4rurMMkgoV2gJB5WGq+b/jQboBQc642MfFEhJQsGQ2Dx++QgPHu
 rDiZdJT1UM92F8avDTnB/DQ4ipWsJnp8z8YAiqdkblz//6g2Cj71HW/uizFNFCnbrnw1uMTeJ
 VzOkYJq1jZ63xGacW6hB0L/ERqncqCLF5IFqAPXIbtWV5JKIwyLeJKyO1YReGZTdDd7adSHfE
 eXIh0LIBKUgGx2FA/CPesxDQDLLWm/3M7YTZPe7jYTTBxDa5wkgKObD12V7rZMPOJqDWmlx3q
 PF1iMMYKGN85ZOGndNralsIm2Oz1XicsvgymgViSDk3gMP/OeTvyVt/wZrWrKR64JAKJjFPRW
 M7aynqK9f+NgrYu2TxYX0SnLW+526Ge/GmjNgf7gqbfYEiSiBkxuDnJ8eX47gkm3FV78/44o/
 fErP+uh4HrHkIJKENCkhwub8bo4IW0iKI36qpjdebngNfqiJKroKbzhjT00cCaJJzwmprONpP
 8mAJd3fn0lJ6sLm6IRB2HHA08rxAg3JKMSLp2qoSdWTt+sfYY/XVBOmsQaszPBvNIuI3pu3M/
 a5TTLi1LIjhF5ITcSMTo8sN8Nh1XFURK+Tr/UWF485+h2hnMaQPM56clDvDGyehn4/5gurwuQ
 F2Sj+tBaMPYdrsX5FMkcqgKh93PcBCePWyFwV4Ge5BZ2xWXdgPKgMoDFG7q8DQAa4Xkl1GU47
 cgPGax2UrMKrysSvXviKlAynJJOVww9eLf/trYFtJy4BnovuCBFGVbdf4cwNIyxT2qSqFXYrr
 8A92VZcD6+YelLJjvnA2jDQkpMB7t89Ud3WG5TPSIortky47NR6LMToWOsQbZjcOuPknUhV/b
 nanwqvQqVRPX8PbFTsPQ1QXafFKSwY0XCCcZ0RkyDzaQVfMZ1Nd4zYG205eV5earrTnTt1gvE
 HfwX3GwN6NugrFIJrz7+jCcryAxFdJcabJDg8vUg4CyFxwg9nwwRQkHpDS/gbBhcREhol2xjG
 ugIGlkbF+rxrzy1Ax7x7A73i9r4/64edJMXfgQHWl5lmOhvx3xsOcec27sqN4+hWYmI5ivGR0
 B8WsONDmjAXeU+Df+Nl3mxa+Tesh36yMXyamu+yK1LTeMETiJP/MeZ8TKSdUxV3d7OOSm4M3y
 1CWun7hhI2mbB6iLnJcE8Wtskfmk0EyJW4GfgfuJL1mYNwCPCCfg/CC+l+nA=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> I created a cover letter but failed to send it together with the series
> :-|

Did you omit the address =E2=80=9Clinux-kernel@vger.kernel.org=E2=80=9D fr=
om
the recipient list intentionally?

Regards,
Markus
