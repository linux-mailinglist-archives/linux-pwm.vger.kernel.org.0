Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6A82CF75D
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Dec 2020 00:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLDXR4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 18:17:56 -0500
Received: from mout.gmx.net ([212.227.15.18]:39063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLDXR4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Dec 2020 18:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607123765;
        bh=wLumdO+uCQMFjKePTBtgmZ5TIViEg4Fo+8J7DjCzRTQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hsd+Aq6saaHs37rnpipMUaUFeH3/yAQOmRQWhGs2SdM7+6c1CP3CeBSJ170b4WfyJ
         kIfz4F1hKfAC0Xm6XRvy7Jg4AevxCU4IUYHwHZ91rcZ3N728/xPFhq3qdeYyC7XxJX
         x2mXqbenj9yBEM59pqTp1TQlYwFcIOqVayEuFrCY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK0R-1jubA53QUj-00rJy8; Sat, 05
 Dec 2020 00:16:04 +0100
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
To:     Sean Young <sean@mess.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <e4a124a8-0905-4504-62e0-a809163775fe@gmx.de>
Date:   Sat, 5 Dec 2020 00:16:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204084417.GA2154@gofer.mess.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dRjiz5QRIZAzWPKxdMiC16hqzB3oSyqLVo5HXxZKEnaHmrFffZh
 ev1gFPCewmETUPYyeyeSAxVu+IpFKrCeBE+oIxnXwDA7Lw+a6SGh6fTNaWTsnQNTNvrZOuy
 qL3U6+1ne9WLrC5LoETAEiri6/afCK+U0hLv7NdhrMCJVaPkJs6NPtv8FfJG/SJqLl80AH7
 X8gbjmL65LTzBUbD+L4xQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qfbF1NQNmlU=:7PIPQydHq6zwsnI16HUYA+
 xRYzg06p270IPAIVWwx4vImHDjyRar7fWhUrjB7RXHlMZ34F6H/1PhfiOzpzb+kKXQLstDtEA
 j0WnS/+X/uAdA4AmwT+xtWWV37KaXVsl+6vObzs2JwMotcRdPThvWsD4FIf3rhZukA3yKZxqL
 DG0Jz9GDGnxNufXdgFlE34R/o5TAzDNcw5HCuq8NGzVLXtY4AS21B2SoOLCuzX1Acr5S5qWc8
 yDWbQZPX8XDh8mzJ98CudyCj1W3vhbG5anxXmQ8jtUUoGpYWxQEM4PEON1o3BwTB4DuKHjotz
 ZqwmlmsQbmWGjm7uIRJqJKsY1mnEyscG6nULoIVnacEuN8BgjR+1/agUFcLYKtZRvcsLDPZ2G
 qbFg06PyTH1hRq6d2XgEBjY4x+LUPH9y435IOZ6ccH+MC5DU68MR5k33IJRSs5gDsROuDcOy1
 SXliN4ObNnWqid+AVoVOOzmOnvfLP2GcT8+3nO+or+9bMazBFhEFg+2vm4gd03k+PS4dCTeqi
 fM816wqDxc+dR52Bqu4B5roANoMvKYIsvzqETQPeXRAGmi5YOdVlklol95+J1H6epvgo/swyk
 VqXtBvi3kiWktuXJdW5sDmSCjjJjMLdcgoGWzFirZlrmXg8i095agaYCfOPEbrFfPIet251ig
 Bv7LxRM/lDM5VcGn2V+IvLP08Vw7/z5aaDWzW1WPZGuK3Z2z2ZWEHUBi0xVM4+gzjPGR7bBdt
 8EOQyuPL9QOF+EJrWj6qUa3nAeMnOjl7WTKq0DA9y/DDUxkYRG/E+gfqKaCkqNKi+HGi/Cq2k
 QhU9N/H+CZjHuPnIS4tVSCgUGRSgBvRWzSxKhT7YDJyWJilHJVoscAQn7fRkhNhZ/pmt1pfhT
 VmZhA88UwriGTIHjQLFA==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sean,

On 04.12.20 at 09:44, Sean Young wrote:

>> What about an extra check then to make sure that the period has not bee=
n truncated,
>> e.g:
>>
>> 	value =3D DIV_ROUND_CLOSEST_ULL(state->period, scaler);
>>
>> 	/* dont accept a period that is too small or has been truncated */
>> 	if ((value < PERIOD_MIN) ||
>> 	    (value !=3D DIV_ROUND_CLOSEST_ULL(state->period, scaler)))
>> 		return -EINVAL;
>
> Rather than doing another 64 bit division which is expensive (esp on 32 =
bit
> kernels), you could assign to u64 and check:
>
> 	if (value < PERIOD || value > U32_MAX)
> 		return -EINVAL;
>

Sound reasonable, I will adjust this.

>
> There was a problem where the carrier is incorrect for some IR hardware
> which uses a carrier of 455kHz. With periods that small, rounding errors
> do really matter and rounding down might cause problems.
>
> A policy of rounding down the carrier is not the right thing to do
> for pwm-ir-tx, and such a change will probably break pwm-ir-tx in some
> edge cases.
>


Thanks for this background information.

Regards,
Lino

