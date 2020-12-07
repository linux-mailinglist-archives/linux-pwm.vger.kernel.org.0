Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B412D1D67
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 23:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgLGWfv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 17:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgLGWfv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 17:35:51 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D4EC061749;
        Mon,  7 Dec 2020 14:35:10 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id x4so8501020vsp.7;
        Mon, 07 Dec 2020 14:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JocXKKqkq81jtue3iPNbkusuvkat05xi0rcFW4AvdSg=;
        b=t28T89OUdsfeIZlpErYxluOBmLJ4K2tpxzV76dzXD6v1303zl6ik0UYfHKq3GR7o8r
         w1mdCjqT6XtjsyblutRdAsG9dW/ovYFi2xAHVm15vRL1bv4pa/a17N9ang9anIpBBzRx
         QdVc/3RfuE9CxDasTQi6YxRmiLJNvYHUXtvE1BeqC/OuJJLk3tb3YEjz11elLrAkErws
         FaMXwkJcRKAi4pFWmkJUMT9WuHYgCCnvle5firamvaA6dmLe2s2vc+ayXMn78reJfU0r
         vQSL4o6ChB6eoehiHyoYurChsIBo9t/2M/vZjvZv3dF/aiVLf/ONaKjrFczj0/G0KmdU
         Ympg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JocXKKqkq81jtue3iPNbkusuvkat05xi0rcFW4AvdSg=;
        b=aHV19vIhgLmUBjFtEJhhYOgZJXG8GolzckhwTQfvdephGSdHEh5AVhKAapeySs7spD
         sRhNVcJVDtC1RVF1BbWgnNr/yz1KWKfmB57fyj0McLRvsueabDZ56jMtVweYeejYAwdP
         SWzeWrbb8MohaINblQ2ESbci5tim7De8F1KatMdnDQBqZR8owyld8msj7e462pnz2F3o
         HG3r/8RX7qdkyk0Asz2ozcUs+Mi979ahvtHCvO0+10E0exhMmFuddNTbs0b1nACrzDEJ
         joc4S9jjZNw/zjig6oxa6zrSnmExbitHl4YsZIvcJqNQHfDhW+P/DMal1Ed3iv7MTv7k
         /QpQ==
X-Gm-Message-State: AOAM533AEHQtKxVO8+Mp/pUsgBKorwNdof3O4yGIhSXirKoMmmfNS0CF
        dsVJGbToKmqAT6HoZN3C3cYljKN13ZqCESTw36Q=
X-Google-Smtp-Source: ABdhPJxhH/zFKiH9Tl6BKyCnmPRgQ/uI3WmwFvdPGACbrzDTWzWIW2+Lq/mt2cl9JxTOzlMqOI3PwPt+Oavn7WSWs1E=
X-Received: by 2002:a67:e43:: with SMTP id 64mr14109094vso.40.1607380509710;
 Mon, 07 Dec 2020 14:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com> <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
In-Reply-To: <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 7 Dec 2020 17:34:58 -0500
Message-ID: <CAGngYiW6_T8GjLvHrzNk+nUN5L81BwivBTRQ4GofF8LOf1qexA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Dec 7, 2020 at 5:00 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> This is not acceptable, if you have two PWM outputs and a consumer
> modifies one of them the other must change. So if this chip only
> supports a single period length of all channels, the first consumer
> enabling a channel defines the period to be used. All later consumers
> must live with that. (Also the first must be denied modifying the period
> if a second consumer has enabled its PWM.)

That makes sense. However, a possible wrinkle: when more than one pwm chann=
el
is requested, which one is able to change the period?

Example:
1. start with all pwms free
2. pwm_request(0), pwm_apply(period=3D200Hz)
3. pwm_request(1)
4. pwm_apply(1, period=3D400Hz) fails?
5. pwm_apply(0, period=3D400Hz) succeeds?

And if (5) succeeds, then pwm_get_state(1) will still return period=3D200Hz=
,
because the pwm core doesn't realize anything has changed. Are you ok
with this behaviour?
