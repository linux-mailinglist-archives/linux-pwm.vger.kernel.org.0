Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D397E7005
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Nov 2023 18:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjKIRRe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Nov 2023 12:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjKIRRe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Nov 2023 12:17:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6BE30D5
        for <linux-pwm@vger.kernel.org>; Thu,  9 Nov 2023 09:17:32 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2802b744e52so1812112a91.0
        for <linux-pwm@vger.kernel.org>; Thu, 09 Nov 2023 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699550251; x=1700155051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XrcCNqDdhGRMVH+CVL3Mh6Lfi1vR+qAOIav9EoJwRI=;
        b=HhRkdOj/jZZT0BcXD65SvG4vnxgk9k8MmIXyojzgXm8/MXsHJRAXpsDKPJeo4aV0yN
         WABC8FpyHZcJUf8FK+tzSwrf35e0F1yNUUyz12mFf+z/1jvPUw8t+jwwrAg27ARgjwuw
         K58y3KDOVb84FIcW3qudy2d2tQJDf1u7gxeh2fYGUFlJ1auu+x522Bo9Gd4p5ohV+0wE
         bdnJFcMXCPuVBIPtGYb67ZqjsRiTzVXmj+ffQLiYh0qk7wbK5jBsA2VOjCLrMDXMvxzr
         TJoZi4Irx0fDJnacs8Y36NHVAuhK9uwklMd3q4M9pG8cl99NtcKUb2FxAvRVAsjSBgMM
         PO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550251; x=1700155051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XrcCNqDdhGRMVH+CVL3Mh6Lfi1vR+qAOIav9EoJwRI=;
        b=u4tJgIpIgIFjSsovvE17tDoonGpvU+a7wf9jRyqjMCmB+olWirmUJzNVcka+gSUy1n
         zAgJyopSXisJhBx/ZpNsjjpeVsPYvd4bwGGSlemjg1UcvR76ihn1LuSIQ91MoPM6ehdr
         c1Utzpg2cYsjZtGvc/S42qk0xwXHtO2JODR0XseeMg9CNp1S1N/EbxkPDF05H535fn4E
         6Cm5dLr4eBDU3YwQSXM9a1/JTMc8097UPGe4ZyW+QHrwCrB1neILsXv/Av5aHfoTwQbV
         E+n6Gnw/yZRmda1fD7eZFvP/XxNZJ9KTxNZoQb/oG6ajyLzIC9Bo31yM29FxAp4+28pF
         CjIg==
X-Gm-Message-State: AOJu0YxdoxZqEqmTJoj2ApghQtIfiDVQ1jzTe2b5ii56f+cNEB/tuwz4
        u5k+fTGwOgeJMd/1mEKnHYiRF6XW8p8VC5FB7dxDkA==
X-Google-Smtp-Source: AGHT+IEU+g/mPCOvVEq8Q3n58WTTnn/5lUY9PZtSeC/rp33EaGT45gQDxrQx0su38GxRFDoqUGOluqibblOr4hDwi3Q=
X-Received: by 2002:a17:90a:6349:b0:280:4796:59b8 with SMTP id
 v9-20020a17090a634900b00280479659b8mr3597320pjs.9.1699550251597; Thu, 09 Nov
 2023 09:17:31 -0800 (PST)
MIME-Version: 1.0
References: <CGME20231109104759eucas1p1fc7343ea2b113abd18397833d70d6835@eucas1p1.samsung.com>
 <20231109104748.2746839-1-m.szyprowski@samsung.com> <20231109104748.2746839-2-m.szyprowski@samsung.com>
In-Reply-To: <20231109104748.2746839-2-m.szyprowski@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 9 Nov 2023 11:17:20 -0600
Message-ID: <CAPLW+4=jdmj1nddYupB_6D4FZXc+fL1SjM6m9uNgEHbdZqUjNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: Clarify PWMF_* enums definition
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 9, 2023 at 4:48=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> PWMF_* enums are defined as flag values (like 1 << n), but then in the
> code they are used as bit numbers via set/test/clear_bit() macros. Change
> their values to sequential numbers to clearly show that they are bit
> numbers, not the flag values.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  include/linux/pwm.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index e3b437587b32..95c895c63cf6 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -40,9 +40,12 @@ struct pwm_args {
>         enum pwm_polarity polarity;
>  };
>
> -enum {
> -       PWMF_REQUESTED =3D 1 << 0,
> -       PWMF_EXPORTED =3D 1 << 1,
> +/**
> + * enum pwm_flags_bits - status bits for pwm->flags entry
> + */
> +enum pwm_flags_bits {
> +       PWMF_REQUESTED =3D 0,
> +       PWMF_EXPORTED =3D 1,
>  };
>
>  /*
> --
> 2.34.1
>
