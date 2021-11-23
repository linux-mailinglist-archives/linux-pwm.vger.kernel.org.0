Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AAD45B033
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Nov 2021 00:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhKWXcF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Nov 2021 18:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhKWXcE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Nov 2021 18:32:04 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2726EC061574
        for <linux-pwm@vger.kernel.org>; Tue, 23 Nov 2021 15:28:56 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bf8so1378312oib.6
        for <linux-pwm@vger.kernel.org>; Tue, 23 Nov 2021 15:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RebxArtPB8XHBkXmzW1vrftg6vGj3Xn6+aJPH1ZiVlg=;
        b=eDSM9ztdUGUrvtlEqqelBNHbP+ASOdDEWqbvnBR2goUV9AgazI0wFOuJym3DJqfRwL
         EIGkzFuTqimqMxfJTMWJYa1wY0FT+PKnMgGM8QOPNN5q84JnKTPPoaQtsZyr6fRrJBMN
         9IMm5Rz1R2mCBpxkJ3ej6CGRFbKDC5DH6evxml2vgOv7ZUo8ZnImxmsNoRKZyB0uKf3A
         J/Tq8fpCvb6eQe1Sa52BpfVHndsYD31GFUYKdMEjHgISzRO08hRz/ESZA5Ukhqw9PP5n
         PLmhRJd/nv1PO9w/msSaOJIho6DbRda+SmgV2xb6YFrrzpMHopSG7x9hDQzXU0irdYbo
         nYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RebxArtPB8XHBkXmzW1vrftg6vGj3Xn6+aJPH1ZiVlg=;
        b=U02dQIff9vOYKqsHd942HST0BXA3XifDxbMCgOfTt6Yf0oDW2Cxn4mF/6R+gVmelCt
         A0pUqyCf6vnHPfQZnDIwxhkxH2M09eNO/S+zcYARRKgLlqkyvAXxOQRuyJbMhDW3BJKv
         UN7cFXk2C7fGoKrdJDp8wWOrSkCdNVZyybzesrIFp2h3HU0fttSRzT0RupIHWRJnDM/v
         L6eCKY9z2iQGMWAhRVWw2fQ+qEAyqFyirppKRZcLN8n+Q0Wn09dt2UbHm9eC1djQ4W1X
         ldlGl1g/chRgxSa2vqKYl7BbfpOI0xDn/opOaqJS79XPCa0hUMoi4O2B/GFo3Z+LaQvQ
         4NGA==
X-Gm-Message-State: AOAM530Y2RcGCvX92Z8UDRTQOG+xut7eJUOOMUNgxPN2SG3gUmaRNmoD
        l9Qzlq+Mb9ir3UUKVSPducmsBqTu3jqX5PY2W08EO4N7lzM=
X-Google-Smtp-Source: ABdhPJw6QCSFSJpAeJZz8Uc8QMqjU5R/1Y8eUV65DKe7SEi04qUZYGsBgnlU1CseAzbhlYyqsN8/OTzPGMs03F/cqyQ=
X-Received: by 2002:a54:4791:: with SMTP id o17mr1137441oic.114.1637710135528;
 Tue, 23 Nov 2021 15:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20211123092939.82705-1-u.kleine-koenig@pengutronix.de> <20211123092939.82705-6-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211123092939.82705-6-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 24 Nov 2021 00:28:44 +0100
Message-ID: <CACRpkdbHVmB16+zroKHH+FiHra6m=NxYhnttWKPUhOFpfAs10Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] pwm: stmpe: Rename variable pointing to driver
 private data
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 23, 2021 at 10:29 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> In all code locations but the probe function variables of type struct
> stmpe_pwm * are called "stmpe_pwm". Align the name used in
> stmpe_pwm_probe() accordingly. Still more as the current name "pwm" is
> usually reserved for variables of type struct pwm_device *.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
