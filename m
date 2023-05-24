Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF8970F605
	for <lists+linux-pwm@lfdr.de>; Wed, 24 May 2023 14:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjEXMQF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 May 2023 08:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEXMQD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 May 2023 08:16:03 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2743595
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 05:16:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-534695ce83dso118734a12.1
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 05:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684930562; x=1687522562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lUpJMj7kq9AStnoEOZvLbmr6Mog0+D66Sv8eRgdqck=;
        b=M354mU5AFCfvix8Mnzqx5jcUaJ/kCfYA4hAfq3CK/p+vUxfE7JfdwvJV0eaZzeEHVw
         hShmzeBs9kIUtNXt42gTuHnq1h13FMQZjEbIxKs8t2x8xyJDR9mRMTRSBeREgCBzIx2a
         9iA8bZlcHL5PnJfEKXgSvThMjjS4yvaI65dI8HPfD8a3U2Y0jfI6DtNYiMWC4xGePuD0
         RFgSPfxG38e+FcrCIFswYEt5JDsnXVUcMugOFma91sMwpE72CKKs3B5SYyySw0gLSIgE
         aI+C5cZFQYmpf9dHOKiacecK6UO89dXPUYbCFLTiusSv01RABV/motsZ6bH64o68Yhlt
         IHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684930562; x=1687522562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lUpJMj7kq9AStnoEOZvLbmr6Mog0+D66Sv8eRgdqck=;
        b=Sc4goCq92j4jOM0+YsqZ02Omseaop6AinFlsBPLY9YJUJS0nr5PUkeTs7cbldskCfP
         yiGhmIVtcg/rEjK9y/13jYS9An6hiA5Jb/DkacoxsuuMfX5p77TRee6bDRXhnjzBEr32
         1FJZSrWb2ej6AJtCuB5CMaV3SMvy1A87KNnu5LZlUe8huqIuv5BwMD329aMFeZgB0j+R
         Rbc0M5k/cdsCZhkCrwOx42nVN6YjjJhYXwmAeBcCJUwSAWoWd9uGGGI5P0o50qGgwO5b
         LPkfwl6Jgrr3BO0OIuxadTT4qo1OoU5bjTQN2Xa2QSEcMNHolVD4phU2jerHeewVDwhK
         GS6g==
X-Gm-Message-State: AC+VfDyWFJrsH8v7wpX9UpV0FcrAVZp6mvMJNoFJSDkDbnAyO8jIKSnA
        O5sXfTopmQhV9yA9JsAeT0Qq4fB05e7pCm9tySE=
X-Google-Smtp-Source: ACHHUZ5GD1t5OF2Lli77bi8kl5vucVniviN8aJuxxcAGw5Er7gCrq3AVqJ+WSUpvp/CJz862+ZjFeqkUki3ueGcQ1z4=
X-Received: by 2002:a17:90b:4f47:b0:255:7cb3:cdd7 with SMTP id
 pj7-20020a17090b4f4700b002557cb3cdd7mr2661703pjb.2.1684930562581; Wed, 24 May
 2023 05:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230524052714.3077-1-LW@KARO-electronics.de> <20230524074607.41ffc31b@karo-electronics.de>
 <20230524075421.00ee0e57@karo-electronics.de>
In-Reply-To: <20230524075421.00ee0e57@karo-electronics.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 24 May 2023 09:15:50 -0300
Message-ID: <CAOMZO5AhdTCThO_SdwK+SmsXBWBf9rJsF4nexzQuO-xAAnBkgw@mail.gmail.com>
Subject: Re: [PATCH V2] pwm: imx-tpm: fix kernel crash upon resume due to
 register access with clocks disabled
To:     =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lothar,

On Wed, May 24, 2023 at 2:54=E2=80=AFAM Lothar Wa=C3=9Fmann <LW@karo-electr=
onics.de> wrote:

> please ignore this. The V2 patch does not apply. Last minute changes are
> always a bad idea...

For the next version, also include a Fixes tag.
