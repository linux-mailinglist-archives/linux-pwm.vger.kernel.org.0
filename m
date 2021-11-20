Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC8B4580F9
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Nov 2021 00:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhKTXjE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Nov 2021 18:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhKTXjE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 20 Nov 2021 18:39:04 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB5C061574
        for <linux-pwm@vger.kernel.org>; Sat, 20 Nov 2021 15:36:00 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y12so59156597eda.12
        for <linux-pwm@vger.kernel.org>; Sat, 20 Nov 2021 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=miohu6SbfONOwXs1AwLBMAYQ0I6KHthWM0k34SPD7Us=;
        b=KbfG5lOwCuU4fJYKhZXBMoXldAxxH37JKquC84SiBrjn42kWCfF/rRtD+E2hNHDEVd
         vuRyU1GDXmDJhT8Kfxdh5bOyp6FYNgxCSsXTkg/GqPzSvFFws//qi24FhOYj8UHwMmmC
         1xYj/dqPSaX+CBc605DYVmwKmzYLpwILnKTFUY3uS5Ca1/YoDFDy0DoosCF2YSStoSfa
         YRFRY7EuAIL/Xa6wGOuPi5aTZxyr4aYOek632+8M/K/w3+TwDr9vanHwzJiezhOp67CS
         NMqsVpiHl5+DLGEv2qB8Myiq7hlLEBtb/I/3OJSblKkkup5/bLzXgYegGK0sFZ//omz2
         nb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=miohu6SbfONOwXs1AwLBMAYQ0I6KHthWM0k34SPD7Us=;
        b=CPZzitsnGXyAv4vFclb57J6BbbmOAMLOLgVjju6guU4u6QWAO9QRi5SQ9dXt8d6XzI
         d9MW5VWB9rqQvbZOvZmqgP99XvoelidergeM3NVda58kHnjDKTsI/FjdxCRWf8DFDRBf
         Ozrq5b+QqnQIcLyvB9hNlv2bQvSLvwZhBPFJkFDyRI26nXhx93uqTRJ0ERptxsgd2Ch2
         aIMsFlR43hTrXhc1YIVpxhNXwigJKLDhjgUguNb9P6/ScxcWvRGSSTksWY67bN3QncHG
         Oa2Ec+AN7gA5IfKg60EPUl4PjY1lvnx30swvtO55kmUsgpULBwfXPI6rSbo9mQBZpaLY
         7ALA==
X-Gm-Message-State: AOAM53195gn1xHvsRoRCmKpBTzydUZHB89DnWuXMaAqlhhROqOo2UDZt
        KaH285q+M3bTSf/sj9nzXOhZ7SqsNyf5LnwnSco=
X-Google-Smtp-Source: ABdhPJzb+Mb/pzMZF6ItoCWBP0DnD24bZ4mfE4rlHkdFJveHiazebKcC14rKmD2Uh1pseETZYxoWlxUleqtrT4mNHMI=
X-Received: by 2002:a17:906:2788:: with SMTP id j8mr23369848ejc.203.1637451358629;
 Sat, 20 Nov 2021 15:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de> <20211108134628.120474-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211108134628.120474-4-u.kleine-koenig@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 21 Nov 2021 00:35:48 +0100
Message-ID: <CAFBinCCzw4NXU9TSnnRRQ5Jo+Nug=oAsB=_0GR3TmBRxSgNngQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] pwm: meson: Drop always false check from .apply()
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
> The pwm core only calls the apply callback with a valid state pointer,
> so don't repeat this check already done in the core.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
