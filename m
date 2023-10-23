Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CBC7D2B1E
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 09:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjJWHVY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 03:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjJWHVW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 03:21:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0F7D73
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 00:21:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so4207083a12.3
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1698045678; x=1698650478; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXFEIIjXJDnknqYDecq1Ocr2lT28f1gIUh/Ja5PDVhY=;
        b=Dm2RcdW3HJJTS8XNSsuRt8EjrCMxPlOMn1KGe6ePNgVOvwgqw6WwAPv2w/CBT0Jt3l
         t9iJpjbMftIA2EWTgRpkpisevKtUJZ/1aaHfTM6rg3/7GRJOhBtkXlhPzVTUBqizcTiR
         xf3ZJVtg14yuhYsrIZmxiQkIdpPuba4fU66EeXaOXjgtD3824p5wVo1ZcTOheewtSsHR
         JQUPlJV2g1r+3Xfw2riWU76W8sjb0L/y5Bv0cWu0vdTehrIvS8GIklPFSYJgHiaEsB2H
         N1bsZmv2doi/Omv62Ii91rwE+AgW0XCDrmMfR8GxekV43I88czzczWCIOHWllKtyk5mM
         meIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698045678; x=1698650478;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kXFEIIjXJDnknqYDecq1Ocr2lT28f1gIUh/Ja5PDVhY=;
        b=dH3oTQ27hNiJuE4XkYUDuCi/73BEzPrZBRsKJ3kq3J5xMt6kxgn/m/BKJqbkUWP+GW
         IcKWhdXZ3M03OlDTT3xS/OXtqs126gBzl9KuCxsPTIrAclG8NPhXz+L2sg+72TCQT8yO
         2duPrZBZTOSAb5dzd7DP9L5a6/NiLawG406qwP60LiBnzAW0jtknUAwo2Ha70yCamToA
         OilzXZymw/Hngzipgpd78Ca8QY/Phmm/WcXpq9GOQpSbmAbp/1Je4jhoK4qbtQeDVQwg
         HCte7IpAwtn6xy6sLriU3dBi63TlX27akFxNbyiAvlVrFbgJ+MmkqQb1gVvaE/std1+s
         INtg==
X-Gm-Message-State: AOJu0YwLreeRLJokE0UZNPpteucO9lyRyybFL2JhXqfb5+nHzIlCWvi0
        sJ4Zx2WLFMyMuHQM8T6CQJq59w==
X-Google-Smtp-Source: AGHT+IFqe/CmfqfzzIPPiPtZyuMLgmVsNA7lgokJECBM3fv3IMpRzoeLdxIXslrX9gPjd48rEIC4Cw==
X-Received: by 2002:a05:6402:350b:b0:53e:782f:cfa6 with SMTP id b11-20020a056402350b00b0053e782fcfa6mr5958551edd.37.1698045677996;
        Mon, 23 Oct 2023 00:21:17 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id m9-20020aa7d349000000b0053dff5568acsm5829153edr.58.2023.10.23.00.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 00:21:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 23 Oct 2023 09:21:17 +0200
Message-Id: <CWFMYF24IN3Z.17JCGT64AHQW5@fairphone.com>
Cc:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <quic_subbaram@quicinc.com>, <quic_gurus@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v6 5/7] leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data
 to support PPG
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Anjelique Melendez" <quic_amelende@quicinc.com>, <pavel@ucw.cz>,
        <lee@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231020182218.22217-1-quic_amelende@quicinc.com>
 <20231020182218.22217-6-quic_amelende@quicinc.com>
In-Reply-To: <20231020182218.22217-6-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri Oct 20, 2023 at 8:22 PM CEST, Anjelique Melendez wrote:
> Update the pmi632 lpg_data struct so that pmi632 devices use PPG
> for LUT pattern.

Hi Anjelique,

The hw_pattern now works as expected on PMI632, with the commands
written in [0]! Thanks!

Tested-by: Luca Weiss <luca.weiss@fairphone.com>

[0] https://lore.kernel.org/linux-arm-msm/CVX5ZUGU9BVE.2TA819U1AI6BZ@otso/

>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Reviewed-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qco=
m-lpg.c
> index 0c6d0e593c06..92fee512d965 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -1640,11 +1640,13 @@ static const struct lpg_data pm8994_lpg_data =3D =
{
>  static const struct lpg_data pmi632_lpg_data =3D {
>  	.triled_base =3D 0xd000,
> =20
> +	.lut_size =3D 64,
> +
>  	.num_channels =3D 5,
>  	.channels =3D (const struct lpg_channel_data[]) {
> -		{ .base =3D 0xb300, .triled_mask =3D BIT(7) },
> -		{ .base =3D 0xb400, .triled_mask =3D BIT(6) },
> -		{ .base =3D 0xb500, .triled_mask =3D BIT(5) },
> +		{ .base =3D 0xb300, .triled_mask =3D BIT(7), .sdam_offset =3D 0x48 },
> +		{ .base =3D 0xb400, .triled_mask =3D BIT(6), .sdam_offset =3D 0x56 },
> +		{ .base =3D 0xb500, .triled_mask =3D BIT(5), .sdam_offset =3D 0x64 },
>  		{ .base =3D 0xb600 },
>  		{ .base =3D 0xb700 },
>  	},

