Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0570A28DD0A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Oct 2020 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgJNJWF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Oct 2020 05:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbgJNJVz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Oct 2020 05:21:55 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D485C002156
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2020 19:01:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so2563341eja.2
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2020 19:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UokA0sKQdr0W5NAQ9oqoGME0zBXQ5+h8uv+YRil27Ek=;
        b=ENnrYc/hM5AHbkKYz17lCLM2js2cn1poTYyLVW7vPfTZRc8E07286YOuhbjJEHMN5M
         Y5ffttf1AjGwF/4WV0gvjSMg60egTPDhxT4auLa7w4g5gMwKdeQXD4dyUEK1ZDVXn1Rb
         DoAMphMDL+D+lMzHqzdx3udjRl4jiTqJU8jJVTv8rlRsAm+B0dBnw2IrU2pC00SDUM0H
         ij9Wnz8R4g8yhvFUC2ZcHq4/OrnRNUocU7+ZJJFG1ys/XXc9Gs60g3N/v7gfWoH3Mkto
         4jKyhPh3amN9372cYXyYrk+FtQFxtjEI8aKr/XLj/v1tPl1rg/+z/yZ4aioGnztIg/PF
         G9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UokA0sKQdr0W5NAQ9oqoGME0zBXQ5+h8uv+YRil27Ek=;
        b=qM12U+kjttjoPK75U7F7VhGuTcXw3Ujdvzb7FoNZ2CsdjrYe9erzP/XirRaGkJJTWL
         vp66XWfTE1UaBzU3Rl4E/+oot4IY7R00VuNKV9lWTUtpiFKnV3UVUIVHf/n6kh45leOX
         V7BxEbQQXe+2cdh5L+TSRHB/Z5gY1/cTSqIM0TQoygBwfkhmu5I4GhRRTbsLASWgp1fq
         yIm/VB7W57Ube60JQ9eptcqe0q6m8pHwnADMVfKIQyu4/FXahlhNtUpa7C9D8/pV5Oqu
         P8k4u9MaG3p4bkXkDVqEzG2NtL0wPC543ykJuR7s/6hdI+8HxnkZqyupatG0qdH8BVY2
         1qWA==
X-Gm-Message-State: AOAM533TIOD5ruw847vnPUmsMJHDL0nqnTRvOiI4Teg3f4ovAFKJdrKU
        klvfEa9alSupaNnakZ4LeHiXSrnBasNsLrCcg0ZvHYFZQUSK0eYM
X-Google-Smtp-Source: ABdhPJziJfGCrzo1mVoJINruC7NbajNtTXinTNUDVRvYw47uRJjF+I++UsBzGKd8uIE1zi1Zs/0HSKVUmCQqm+XEu6g=
X-Received: by 2002:a17:906:cf9d:: with SMTP id um29mr2773271ejb.307.1602640871135;
 Tue, 13 Oct 2020 19:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201013081321.660884-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20201013081321.660884-1-u.kleine-koenig@pengutronix.de>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Wed, 14 Oct 2020 10:01:00 +0800
Message-ID: <CAAQ0ZWRrR=qWZ5GQ6zS8q6Hp=_bdooT3qNMLY8Jrzpnyu9jHHg@mail.gmail.com>
Subject: Re: [PATCH] pwm: zx: Add missing cleanup in error path
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 13, 2020 at 4:13 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> zx_pwm_probe() called clk_prepare_enable() before; this must be undone
> in the error path.
>
> Fixes: 4836193c435c ("pwm: Add ZTE ZX PWM device driver")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
