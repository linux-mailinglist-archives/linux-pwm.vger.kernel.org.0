Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8883C2B9A2
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2019 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfE0R5k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 May 2019 13:57:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36597 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfE0R5k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 May 2019 13:57:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id y124so12434603oiy.3;
        Mon, 27 May 2019 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hDEYY5ygEYM7eB8269ZdfC9BLmmN/DHPKYh4QFppUlg=;
        b=ToqlEVP2NUqk1yF13crV2WHETC3Rsq4ZiR2PYfd/TyWMJVA6FhZGrByCR6zCejUNzX
         H6kN3G6X15TWMGk7g5ytqjtUJDlelgsy6siA8+nqU6ejM8qsDp6RG8U+k6SQgI0QogBs
         kvVja4Yi/60/tOSkYZB/Y3SJRzQFyoHtkbEk6V9z8W6L1HWWEUL8A8i8+MnAj7PdRTk7
         klyBlz4jTut2pFPOc4O/mT2mnfPwflAZQYVx5Tcx7RP90t1YgaS3NWbfqaMemxgWisUW
         3DQhU3KWZ4LKOmQqVzvxmQDF8FcTcjxebNuN+CcE9kiBuMNLEnX1f8DBCrbYIdzJe5+C
         f80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDEYY5ygEYM7eB8269ZdfC9BLmmN/DHPKYh4QFppUlg=;
        b=hk2troikOlVDMwlGktiRSyHnY1i+XbilR83tYlB9b88oZ7ulD8f01S7klRXvQNzuYj
         ccVfomFIKyhQKUS9nuRq21hC3B9s/0hzKuDQajY5kcUIdQnbCZyVTORRDHFpk1SEjM2Z
         Q+Jilozd+0Yowji2NExTTcR3Dl4PiPL6PtdkRsLHnDJB0pviWOTl9V5OoFuzz6f7Xj36
         2Tzka+/IFICUTk1NZgQb+YTWZbvxkcBrbL5Zf2rQY4HlApkizmSf2dnOmg+9PN33s4mW
         jmypny9kGT+LrWLi2s3bALPtvJXOvNOXTNGsVCc5KmdqMUPPKXkM6iW8c16iDxi0CHuG
         WrNQ==
X-Gm-Message-State: APjAAAV+TfOSq4eF2cxZCYWDT9yP2P536ekv+mdE5RVNRlddaXxgvUk0
        q71FEfoEtsuKgDKwkQUjdb3KxIqV/8gt6Q6GX4E=
X-Google-Smtp-Source: APXvYqzab+WElPiNBsDpIzidV2Ij/UyqpF0GjvkeY5qPyeOb9lXKwJVd5EfTjjin5MC7D7V4d97PzrxHd9FeOB3RKqQ=
X-Received: by 2002:aca:4341:: with SMTP id q62mr131767oia.140.1558979859769;
 Mon, 27 May 2019 10:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-9-martin.blumenstingl@googlemail.com> <7d169605-e117-70d4-5c66-47d2f80f4d4e@baylibre.com>
In-Reply-To: <7d169605-e117-70d4-5c66-47d2f80f4d4e@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 19:57:28 +0200
Message-ID: <CAFBinCCyVHAG3yum_ty2dWXGaScafRcNPU-bHjxaKu9kzr8xQA@mail.gmail.com>
Subject: Re: [PATCH 08/14] pwm: meson: add the per-channel register offsets
 and bits in a struct
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Neil,

On Mon, May 27, 2019 at 2:28 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> This looks a little over-engineered, but it's correct :
my main motivation was to "not copy the 20 line switch/case statement
from meson_pwm_enable() to meson_pwm_get_state()"
I extended the idea that already existed for the "mux_reg_shifts"
array and made it work for "more than one value"

please speak up if you have another idea in mind, maybe that makes the
result even better


Martin
