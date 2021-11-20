Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860154580F6
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Nov 2021 00:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhKTXhm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Nov 2021 18:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbhKTXhm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 20 Nov 2021 18:37:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E81DC061574
        for <linux-pwm@vger.kernel.org>; Sat, 20 Nov 2021 15:34:38 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so59489227edd.0
        for <linux-pwm@vger.kernel.org>; Sat, 20 Nov 2021 15:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tv8HLzUluQkTs0q0uddjhiVOF25UCticbPEqcPKHBjw=;
        b=fs/FzKGJXmddVV2n/avgGcBD16MmtHPBNm3GBjN5k6cY6p6tIvtTvs18wvvFoGQGPB
         iY6F6UIySX91OVy6aUhPzd+14km05J3c+40ytmNrtl55O1MUhLbd7Z4rrjwv58HroSFv
         DsRYB+bhtLU3qO3JwTAmp6Fxmg8Bv9SVYIHjP4/HF6piYdKMqq/JG7d8my600+CWe7W6
         Kva4o6F4dlYnpkMi9G9AzayFCz+VqDxvCTKCDigGeRxZ6A+sR2qbpmvv5Ofb+sieYyh7
         YMJhLZ1HcDWXYtC8W3x31wJSj5WcjATXsOnmlFgPKyqP/xm+MwQLQcEKE5PMURWgYWy/
         6ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tv8HLzUluQkTs0q0uddjhiVOF25UCticbPEqcPKHBjw=;
        b=ETXmm+E7DBtjN1xsQr2GSByJKcK2kRb6rttWPKey4texy/d0nec5PHLDpuxdDL8dLb
         FpN4Hj9gbWlc6wWDfuSTLgZv1R7CGqESe2Z30mgcMRDk/Oory/n2+qMradCxTHzofJ1P
         5Sm7ol7q818R6GAJ9kcDOrFvOS9OPVZ9wn7Njpu8qlMOTo0qqT2xMxeRoTFMnQB/vQlt
         c2MLpz/QXFk4q4e+bnubviIu9TIYWvKpHj5zGSr4o+g2foYw3+QoyhJudxRibFueJ8TB
         M1KS4K25l58gWIKp3EClFK/ZU8eSBJkCnHgKjUyhqbTOrBk8v4pFSahbRx05fpw0xgzE
         jfrQ==
X-Gm-Message-State: AOAM530cBSH1QhT61VcHC0Mzp1WZsjfrvdWyGQNwHmKy+v1v9sufnpBo
        1Q0nLm+IO3D5jgdWAkYOMIn3tfVH1C0X84/+qHDBy1k1sbA=
X-Google-Smtp-Source: ABdhPJy0tD2Z6ScIRSCnvVicKFa+RTzFVjEzxt9euVHdrHOasoGnTuE5RGOERYAAokG8NbHHWUNdKM2CTwzzMNQPMMk=
X-Received: by 2002:a17:907:6e8e:: with SMTP id sh14mr24614498ejc.536.1637451276616;
 Sat, 20 Nov 2021 15:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 21 Nov 2021 00:34:25 +0100
Message-ID: <CAFBinCDW-E6d5HQUn0q_-M-Gi4+tXiGV0NBg16iyBUFJC11e7g@mail.gmail.com>
Subject: Re: [PATCH 1/4] pwm: meson: Drop always false check from .request()
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
> In .request() pwm_get_chip_data() returns NULL always since commit
> e926b12c611c ("pwm: Clear chip_data in pwm_put()"). (And if it didn't
> returning 0 would be wrong because then .request() wouldn't reenable
> the clk which the other driver code depends on.)
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
