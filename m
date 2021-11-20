Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6C4580F8
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Nov 2021 00:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhKTXiy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Nov 2021 18:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhKTXiy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 20 Nov 2021 18:38:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FFDC061574
        for <linux-pwm@vger.kernel.org>; Sat, 20 Nov 2021 15:35:50 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v1so25747715edx.2
        for <linux-pwm@vger.kernel.org>; Sat, 20 Nov 2021 15:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HC1SzaAEYf39/EvZxx04OIpeGEanP6T7XQemSMatYLU=;
        b=c7XV7DlIA72x0bpWTceTwmuwI+uonsaCCAIPwOjAj4xjn4dZvGFfLVNNl3YxEPkMkG
         +Jei94uBBYROBq3/XD5J755kVb8Y4SdKU+uVqKuA6/f120NZbsLRcb3ywT4BqqI5rnmp
         h8AuiflI7yk5GcofuDkd4JVNfh8zzSXYfBTh8/8qW9Mja/jn73/WlFeHH0CE1M1qgps1
         JRZslrmwi3IrKEwZHDgrXL3MbZLtPprfi0ZekoyH3s9oEprhtMKLbkUc2DRaQdxCSM8C
         0l21/BBDb0dAGlCHE7+yhzlc3XHHD3prMhnh2Hc15TlsJ9JQCR1VnkklsXdF2vIrf4kz
         0vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HC1SzaAEYf39/EvZxx04OIpeGEanP6T7XQemSMatYLU=;
        b=E88bLeixH2Y1p8oQWRkUtOpJIoxctHOvWfc8VOnMx/TCb2zZzEFFhNVOnAyRAIqes0
         v6N/7Fl6Vd/gQ82kv5NvGbBXYyjbMc3fZEUG9qwugIWd+LMgHnCKbvDhHzDFNdQsr+5f
         HGmF1WhJWlTUQj3lSjKWju9R7K3IOIShJ1P6g++59ljnyb9AAVVq8u8tDgG2DYK7fWuR
         RFY3Ylt7B9b5u/RDa/q1HdtxMQGTEsTzH4wcOxjYqrdWQ5vuC05sueU/8RKmB6I5HIHv
         +Lfookj/AJQw+1wFNMbYFet4Oh8PFnHilDTuTTCjkH+SZF0Mm8tsCyLp0eSGJ1JZDqSm
         cTYA==
X-Gm-Message-State: AOAM5316m2hrPsujwAgylnmAXj+qNmju4fDKZYa6wbpBGbRKgxJMmecb
        KbLm9xlR8RZ/QlqlRs/JsFJfsMb50BuasdC389o=
X-Google-Smtp-Source: ABdhPJw4VCaLGbozZaTFdphS2Rl9EbqNz24USVqNs5AepkqJ75EQVe5HNXQCP9cAeLbJaJTVupQBbSrvEL8nZDeNb5M=
X-Received: by 2002:a17:906:229b:: with SMTP id p27mr24029990eja.264.1637451349065;
 Sat, 20 Nov 2021 15:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de> <20211108134628.120474-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211108134628.120474-3-u.kleine-koenig@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 21 Nov 2021 00:35:37 +0100
Message-ID: <CAFBinCCE8e+7b1PDZ=3aON95M1V_Sa0x9B7Y11mV1t9GT5nHYg@mail.gmail.com>
Subject: Re: [PATCH 3/4] pwm: meson: Simplify duplicated per-channel tracking
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 8, 2021 at 2:46 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The driver tracks per-channel data via struct pwm_device::chip_data and
> struct meson_pwm::channels[]. The latter holds the actual data, the forme=
r
> is only a pointer to the latter. So simplify by using struct
> meson_pwm::channels[] consistently.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

note to self: this patch is complete because the first patch in this
series already removes one usage of pwm_get_chip_data
