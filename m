Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE18E1CED
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2019 15:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405946AbfJWNjz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 23 Oct 2019 09:39:55 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392089AbfJWNjy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 09:39:54 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mf0Nm-1hmXPR1EIE-00gboz; Wed, 23 Oct 2019 15:39:51 +0200
Received: by mail-qt1-f177.google.com with SMTP id o49so24470171qta.7;
        Wed, 23 Oct 2019 06:39:49 -0700 (PDT)
X-Gm-Message-State: APjAAAU6rjuILI+dBSQWkepJeZcFXjrhStzYWyvwa71wsCNVgYufVnZt
        iHt9MtJEPLOwsEVZaopkvY4n9SDmIlf2VoWvAbc=
X-Google-Smtp-Source: APXvYqyt7m8OnGbGOfKvN6UapNf8Y0PixnD+b/5MFVO15QeK4AzpoE5xCHBxjuJT4OWklHgs4L5FWsrmt4sucJ53v+g=
X-Received: by 2002:ac8:18eb:: with SMTP id o40mr9289234qtk.304.1571837989082;
 Wed, 23 Oct 2019 06:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191023131049.GG11048@pi3>
In-Reply-To: <20191023131049.GG11048@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 15:39:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1v2-+geD+JbNP-t418ZjntQNSte4rt8c7N6sJdpb3+DQ@mail.gmail.com>
Message-ID: <CAK8P3a1v2-+geD+JbNP-t418ZjntQNSte4rt8c7N6sJdpb3+DQ@mail.gmail.com>
Subject: Re: [PATCH 00/36] ARM: samsung platform cleanup
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-leds@vger.kernel.org,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Lihua Yao <ylhuajnu@outlook.com>,
        Kukjin Kim <kgene@kernel.org>, linux-serial@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Sergio Prado <sergio.prado@e-labworks.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Lihua Yao <ylhuajnu@163.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com,
        USB list <linux-usb@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:NLof35stNYTGVLCCiBOj5shE8fEwjZaac7cdAu2nrrmym/kOcjv
 Qnfa/3i0a5qyJkyMXctYodBV7VP0bHQaFrXIBjwV/gpmENyzPTQE7+sVihuV4liYROCT33b
 9WO8+gy5V2fG2DuQgIo6thaPwkDMewwBExepC4yasYMIPkDiS0zr+8kJODaOpU4HPFc7gMV
 MPShUYeuOvxdtdljHgfJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DaQc5ZGaJsY=:F603/POvpKLPXWa0X1lFEH
 aQjxfOCxGD/pIMHmKlHcbcFD80Nc+ewErQWmvj+Qgp6xaAE5MxfbNNNrin9LMgRKve0v8GrHu
 BPPYcLBIJd/tRGzy7EoHKzi1xCTWBRKPuZW+NRo5Q3c4o6tNWGjXzPGUI9xyOYPIzGuB4sxow
 ECbUMNeq+vtLAQSVxvpHOttzchCbbhPJcjfvA+bQAYJp52FgAuxb7i+4FvHbE4PKIBUfZrfn7
 RTWpJntJNT2FyPouWE44kX34NjZBTj4rpIcCKzq/vJGEBiexW1JIi5IKVdXZvOH5f6ayOyfG4
 N5aMRdit65bReN0guN1SsKJ7uFbD0kzxYt0bE1Mf25djeRlbjBl6eNdESrSyRRUYp5EHOfQ/A
 Sa10vMW4Ena5av/pF9Ivtanmnx43oe8gg/n1e283kgsPXqMvxru3WC5Nzl6w8FtOo8cSrKeIA
 4cwYy4vh4ukZW7IvGkXi8VTyHR5QO0uX/EIi41POGGpNZfuz2RZFE3OQuaZ2ZAWDyKIDIkMiS
 w6MOzO71LwFlzMud8Juwt083ioitXDvT/9TIYbAIAmfnUtb8NIa87LZjq9LnymQfMT/771jDX
 Pv0pU2J8yDYscI2Ar/9iY65bLYD1odSzwo1yupcBRkEYBk2LtDP2ofqM/FtIHQxHEgUCSL8BF
 +DQWO4nbj5c/D8V8Rcbk6xIsj3dpX/eZmDwcjBHzixCuvxTtC6bkTqxwxXemSc09w9sXO96BH
 8wrLVBqppvA4u9/3mwzDk1TPdUl264mBZECZMuP2bwYmiOyo6CZ+bMP0dYsot7zDsLQZk6JM2
 zgDILD/0tZiVRCT1r1eA1ueLWwCTN+MFNjGnfX1TAxma6wIGEoHuP9Uzto3sTth328X/tkiaT
 tiL3D4xHp9lUaPHnTz2w==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 23, 2019 at 3:11 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:28:02PM +0200, Arnd Bergmann wrote:
> > The contents are available for testing in
> >
> > git://kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git s3c-multiplatform
>
> When sending v2, can you Cc:
>
> Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Lihua Yao <ylhuajnu@outlook.com>
> (or Lihua Yao <ylhuajnu@163.com> if outlook.com bounces)
> Sergio Prado <sergio.prado@e-labworks.com>
> Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> These are folks which to my knowledge had working S3C and S5P boards
> so maybe they could provide testing.

Ok, will do. I've uploaded the modified version based on your comments to
the above URL for now.

I'll probably give it a little more time before resending, but they
could already
start testing that version.

Thanks a lot for the review!

      Arnd
