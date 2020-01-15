Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64EB513C2BA
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2020 14:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAON06 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Jan 2020 08:26:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40630 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgAON04 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Jan 2020 08:26:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so18552894ljk.7
        for <linux-pwm@vger.kernel.org>; Wed, 15 Jan 2020 05:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IveF9K9ZvQHL0XCm0NhMK8V0t0Mh/Q+IVIFeaL32PDg=;
        b=Vid4ORIFzRzRLvESZpBs3Ah4aXP8I9dQvIMEoJ2abQEipxzFgRbq9cgs9qV9tZo8dG
         r+ALUOnRFW2hAYj80mACUV0tm2AUq+uiOJAz+mpLJtu+HvdKUdsgrIMqP81AttT6bPAo
         1iHOwyHySY/4v/351X1jQCrAfvgaejUZBV4oWitZ86TuNguKyKPqrdRsNH9EEYJIu+ke
         53zqhsRIr0ZRuBjgFtn1h2jzcpYaaDdvzuXzBv5EnJgleDjRzLUmBMOFTxPgCbwigVIN
         P4Fga4cDvP8gNm3KESwycpE4VyKfdY23u3ZtYMFvsV+t2rXJZt0ViTH6zsxGQsNoh/A/
         pmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IveF9K9ZvQHL0XCm0NhMK8V0t0Mh/Q+IVIFeaL32PDg=;
        b=scKcFBcKsGy9a2/wFceKv5RYokrf6JKi1RVTE+diNGFio9LNQsOG2b5/nIhorzUey1
         xy7yZQVTW0SI4bXed43S6V+gxNfBcF1xtFIJMHUVzc2NFMrydIva7z1u7r7z3xY/aCwg
         a/qhXse5YmcHdrBFmxx4fPGQsPUJVZTcEufnrGhU4li/us7dvFqlB6upg/AF27veLKNK
         3uQ1gUgpufsgLOP7Ya+/Qqcm62e1zbBv1rD0ZjQmnFGgN3HrfEHy8Ii5RLkc5zGZXp45
         8vpD0xL32Rt23GAGvGlcrbB7H85jx6hOzPkYL2x2W3Ng6WVqy76KDQFWTWeEux63lEVa
         VHZQ==
X-Gm-Message-State: APjAAAV96f1mIkmiYMl3Lkcotn/ko0ENfDL2duwdHKsvoGk/we+Nhfbm
        2adwWKgJGDSjiOdukgSqMqv/alaP+qZOtHdAI3ulRw==
X-Google-Smtp-Source: APXvYqzEhjenLEHzG+AYX+BQqoKY2hyu8eJGNOhb1pcFBkrZR5Ijv0RrNHTx/pnJ+SIgH09JhG4jxqIioUO98aLqqnc=
X-Received: by 2002:a2e:3609:: with SMTP id d9mr1649272lja.188.1579094814272;
 Wed, 15 Jan 2020 05:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20200115073811.24438-1-bigunclemax@gmail.com>
In-Reply-To: <20200115073811.24438-1-bigunclemax@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jan 2020 14:26:43 +0100
Message-ID: <CACRpkdbefJsH2km3p433NN2koNck7hgNqLWpD3q4r=Um75GZEw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: clear irq in edge cause register before
 unmask edge irq
To:     Maxim <bigunclemax@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-pwm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jan 15, 2020 at 8:40 AM Maxim <bigunclemax@gmail.com> wrote:

> From: Maxim Kiselev <bigunclemax@gmail.com>
>
> When input GPIO set from 0 to 1, the interrupt bit asserted in the GPIO
> Interrupt Cause Register (ICR) even if the corresponding interrupt
> masked in the GPIO Interrupt Mask Register.
>
> Because interrupt mask register only affects assertion of the interrupt
> bits in Main Interrupt Cause Register and it does not affect the
> setting of bits in the GPIO ICR.
>
> So, there is problem, when we unmask interrupt with already
> asserted bit in the GPIO ICR, then false interrupt immediately occurs
> even if GPIO don't change their value since last unmask.
>
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

This looks correct to me, a review from the MVEBU maintainers
would be appreciated.

- Should it be applied to fixes as a regression fix?

- Should it be tagged for stable?

Yours.
Linus Walleij
