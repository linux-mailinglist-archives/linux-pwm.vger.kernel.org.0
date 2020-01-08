Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA262133F6F
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2020 11:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgAHKkf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jan 2020 05:40:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40445 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgAHKke (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jan 2020 05:40:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so2803332wrn.7;
        Wed, 08 Jan 2020 02:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=siCClIKYBSJbbyV9Fx1AWH7B6zrtxbk84GPvmjQP9HY=;
        b=uHOLhO+V1x6pLXu/z7YfTI/wnHQzDFdVV7yVLl1IfGKQbRkCVrCICV6jG9rUypPsF9
         EogGLFTvAc9j8fguwf7uI8r1ci5Eno7V6B31z8o6eeMIjLkNllMihdtgr6ONtTV3rLA6
         qMI+PxRjF4lxg7C8mUT4jw4QaynGlrHAy5d7/f5ruZFpxiwtFbyLEF0XI9hO3ZSjH8ef
         uXd5QquKbtlHMm8U+vYgedKflsRpd1zv/+W/WqlQcZz8jcF+uIF1I3L2HLz/kIjy77fw
         +ELCoR22idD9rWtySjLDPAh859wY7yAb/wZO4WZQte2D+lie7CFagsBJrPBf732+TA87
         Zvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=siCClIKYBSJbbyV9Fx1AWH7B6zrtxbk84GPvmjQP9HY=;
        b=CISM/1kjCeZGCWAiX8R9vPhSj0HF+maqWzljevAUeD9MBMtQOXwZQVbIGXsxAZDdT+
         HAbCY6bnvglc31IzMqh+maU5zkjiDcPbA3A6oWAJZ4I2L6mee4L+uBfn42nSV9nrom3L
         XPQekWvauTgvZyngvZXDznInXt0RQOuaoQsREB28CdQx/cF7YZjhQ4i8rCjN7FTF6rH+
         1KpCtmMVx7DPB0sUhSr+yGEm7oDCMaqgvqUNqQb/vO3BiyJEc6esL3n7Yn4LcQeeZG5/
         AKOR3AyjR3E0DVOS6Ua1yCdZVPNT8WnUl2B9aHkVz42faDObXF7429XvN8MjVVwStjQR
         hcJA==
X-Gm-Message-State: APjAAAU2hsMj/gSDOEMfNrM9jBwqj3KqK8nkrUbPvrjwp3bDIFyriiQA
        YOAy1f6u0KIwYDJrte6/z74CqlQWHIMvplqRum46XDMB
X-Google-Smtp-Source: APXvYqzPoDrHqZH8i5DPEVIqG+zBSIYdBoE603DpxkU4fYvZsdM0T7mXmsW5RIww8qDtkz4nKlMDh3Cmy9bUzC2jXMw=
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr3640527wrq.332.1578480032491;
 Wed, 08 Jan 2020 02:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20191124172908.10804-1-peron.clem@gmail.com>
In-Reply-To: <20191124172908.10804-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 8 Jan 2020 11:40:21 +0100
Message-ID: <CAJiuCce_zg_E99EKbQa3aQ1fjziB4Ead9p6J8F0wYWk2_VcFZg@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Add support for H6 PWM
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe, Thierry,

On Sun, 24 Nov 2019 at 18:29, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi,
>
> This is a rework of Jernej's previous work[1] taking account all the
> previous remarks.

Is this series ok for you?
FYI the device-tree bindings is merged in sunxi-next.

Thanks,
Clement

>
> Bindings is still strict but probe in the driver are now optionnals.
>
> If someone could confirm that the PWM is not broken, as my board
> doesn't output it.
>
> Thanks,
> Cl=C3=A9ment
>
> Jernej's cover:
> Allwinner H6 SoC has PWM core which is basically the same as that found
> in A20, it's just depends on additional bus clock and reset line.
>
> This series adds support for it and extends PWM driver functionality in
> a way that it's now possible to bypass whole core and output PWM source
> clock directly as a PWM signal. This functionality is needed by AC200
> chip, which is bundled in same physical package as H6 SoC, to serve as a
> clock source of 24 MHz. AC200 clock input pin is bonded internally to
> the second PWM channel.
>
> I would be grateful if anyone can test this patch series for any kind of
> regression on other SoCs.
>
> [1]: https://patchwork.kernel.org/cover/11061737/
>
> Changes in v9:
>  - print error code in error message
>  - no capital letter to keep coherency
>
> Changes in v8:
>  - Display error return code
>  - split commit
>  - bypass is false if unsupported
>  - return instead of goto
>
> Changes in v7:
>  - Fix indent in Yaml bindings
>
> Changes in v6:
>  - Update git commit log
>  - Distinguish error message
>
> Changes in v5:
>  - Move bypass calculation to pwm_calculate
>  - Split mod_clock fallback from bus_clk probe
>  - Update comment
>  - Move my SoB after acked-by/reviewed-by
>
> Changes in v4:
>  - item description in correct order and add a blank line
>  - use %pe for printing PTR_ERR
>  - don't print error when it's an EPROBE_DEFER
>  - change output clock bypass formula to match PWM policy
>
> Changes in v3:
>  - Documentation update to allow one clock without name
>  - Change reset optional to shared
>  - If reset probe failed return an error
>  - Remove old clock probe
>  - Update bypass enabled formula
>
> Changes in v2:
>  - Remove allOf in Documentation
>  - Add H6 example in Documentation
>  - Change clock name from "pwm" to "mod"
>  - Change reset quirk to optional probe
>  - Change bus_clock quirk to optional probe
>  - Add limitation comment about mod_clk_output
>  - Add quirk for mod_clk_output
>  - Change bypass formula
>
> Cl=C3=A9ment P=C3=A9ron (2):
>   pwm: sun4i: Prefer "mod" clock to unnamed
>   pwm: sun4i: Always calculate params when applying new parameters
>
> Jernej Skrabec (4):
>   pwm: sun4i: Add an optional probe for reset line
>   pwm: sun4i: Add an optional probe for bus clock
>   pwm: sun4i: Add support to output source clock directly
>   pwm: sun4i: Add support for H6 PWM
>
>  drivers/pwm/pwm-sun4i.c | 187 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 156 insertions(+), 31 deletions(-)
>
> --
> 2.20.1
>
