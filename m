Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D802FA212
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Jan 2021 14:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404638AbhARNqg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Jan 2021 08:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392387AbhARNqI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Jan 2021 08:46:08 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C3C061574
        for <linux-pwm@vger.kernel.org>; Mon, 18 Jan 2021 05:45:28 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o13so24170121lfr.3
        for <linux-pwm@vger.kernel.org>; Mon, 18 Jan 2021 05:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8dQd7+A52ZDkGB40skQ+3yn5/wm8Y74liVTiwgQqK6c=;
        b=DvMb96+PmIYvqidU8jRcOj+KZduBkXqQTdZVrL4fRnisM0ZffE9WsPkdPgUdSPDp+z
         ja25+e1pHguWpjgqUh+a8JdXXB3uxs39pPWkF+dTYdW9IXkcQZI2k/tdwmHwTNWCLc5U
         fYkddSjz/xdF3d9XE9cYf9lIfEk3P+U212ZbF0rRydxQr4w+8djC/WQIqZNnJvv24UVt
         kRBjT46Ln0S77nNziNfJx2MGMVvRvto57PQr7YIXVAr1WbXnAtluavy2frrDq85D0pRp
         ZUlzfoU1UvqWW6XZRPXM9P9v3MomAT7ujAgxXWCJR+LJJhdKFVBaFepNZ9b+QyLrXuNx
         O7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8dQd7+A52ZDkGB40skQ+3yn5/wm8Y74liVTiwgQqK6c=;
        b=n6lCeqbD2R7sc1am3R3lnHeM3SmahtA7Opy4BnUCfuJAhqgu6PsC/SryrxAoxG2kBE
         BYxOvTSyIfGVGbw1UBC+Jc9WTLdKlUvpuCAH3E5Y8jxav7dRFrN69SCFdRtF0h46+uvy
         22Tv7QYbOJm9fQ0HHzM9SVOtU5YGUdOBwFm1c0Bopkmd9t93kzh9jzyy2G0WGWo/kU5E
         4+h+z9LcL3OAjacuzIlh0t9yDhTglbOY2vveaVhZlQEKf081U83IVG78koliKTNsdU8Z
         5Y2TIH+Kem0doLbdZHm31jyEV+gfjyZ+vPDClNbhwmaShTSE3Imseg6GTcAmcLIJr0uG
         driw==
X-Gm-Message-State: AOAM532CGJ+f20i0EMvUfr8KiiURdr2sHaZhPS10NtEZ3nenA/aIaO4w
        uYczfgFtD6saN/paPF6wnzV+fpoQ7E4I3vGzlxIbPQ==
X-Google-Smtp-Source: ABdhPJx//X8t9NvMhNYOIe0TB1JQRz1HUUgehXzN/xZmy/HlS8dQdG9msSKmENq2LaNRNGAaMs61U360V74Q0LelAig=
X-Received: by 2002:a19:495d:: with SMTP id l29mr11055891lfj.465.1610977526746;
 Mon, 18 Jan 2021 05:45:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610529002.git.baruch@tkos.co.il>
In-Reply-To: <cover.1610529002.git.baruch@tkos.co.il>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jan 2021 14:45:14 +0100
Message-ID: <CACRpkdZvECD74V2+84+TJOW8cx-OUH-nHOouTxgNGSxkqPzsjw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] gpio: mvebu: pwm fixes and improvements
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jan 13, 2021 at 10:23 AM Baruch Siach <baruch@tkos.co.il> wrote:

> This series adds a few related fixes to the pwm .apply and .get_state
> callbacks.
>
> The first patch was originally part of the series adding Armada 8K/7K pwm
> support. I split it out to a separate series following review comments fr=
om
> Uwe Kleine-K=C3=B6nig who spotted a few more issues. There is no dependen=
cy between
> this and the Armada 8K/7K series.

This version looks really good and +/- minor tweaks as indicated by
Uwe:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
