Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA4E6BAC42
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Mar 2023 10:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjCOJgM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Mar 2023 05:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjCOJgL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Mar 2023 05:36:11 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD859775
        for <linux-pwm@vger.kernel.org>; Wed, 15 Mar 2023 02:36:09 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-540cb2fb5b9so251925807b3.3
        for <linux-pwm@vger.kernel.org>; Wed, 15 Mar 2023 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678872968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYQoOskS+fbvCREhTpPzMDMuJWMQA/zd7RgkP+TyrM0=;
        b=IQN/hY56AbzZ1v2FNrGKUmXjBUm+cmnyDS6LJ1GMiRmH1s6fI7E3mQs9CP1LWCfVP1
         h1Ig6rWIWGZ6Uui0rrAERUJMswRoZTiXS6BjtL4PsrONzJkeYRpdh/Oij44FVXpPdhLa
         U70GNF6Ggj/OYTWlhdHy+ppyU3tEVKA8+CdUQIcoyJmB2cwJ3qIDzvVuh4Dd9Dj8QIK4
         4Iv+eFEL1FUlyfxOWTIOYABtdbDa4dv6+O/fAizrqtML9621qRECcljq7DSUdzYc1yXY
         QejbhKMIgmAqy6hSLZ39y3qyKMig7JYxK54ljrnNUwSNRZG4uTe6g697VkNtlWe5UMdM
         lC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678872968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYQoOskS+fbvCREhTpPzMDMuJWMQA/zd7RgkP+TyrM0=;
        b=kMNOUJidmt96USvVpo41ia3Ionv6Rry3JNJGzhuKUqz975uJ+kqjL3ftUCUXEwSxmb
         nb4/ORPNuRAP8l/+0oxrJKxMTGY6/EvE2G8BPI8o8u84waeaL1oXg5y9IxIU37C2kk8o
         NHOsmkoFr532YH6PQO5/NkNuN0WTOAKVtAeJvG63UL/6zOrpQ+FFcCrLqU0+9wn65Q4j
         nX/fixV11lGjrcn+UPInWKbXd2k1kOssrr76ByzRgnl2YN1AEmrTpuquaOv7Da1X+6xa
         KMrKdiIllbJP5o9uFd2b9JN4Hcx6KNpyHhnn3KSeIVBItxPfTfBcQuLys2zNdcXD3hhT
         11dQ==
X-Gm-Message-State: AO0yUKXm07siE4PzMuOa1OQHf6u/GB4QAMrXlgsDhWV1obOfDHmGH3e+
        FEhY/n5pyrYyHgMBaslwy+jcbBfvJ8jjnlHd6n0MXw==
X-Google-Smtp-Source: AK7set9G1e6Y6bwnztfxt/btqXMvwl4/wb2VsLK7KvPZgdg17nAVO2TJC+1fSD6PY4UewmkcTq3WBx4R9IGiqLo9n3o=
X-Received: by 2002:a81:ae4a:0:b0:541:8995:5334 with SMTP id
 g10-20020a81ae4a000000b0054189955334mr8175964ywk.3.1678872968658; Wed, 15 Mar
 2023 02:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-19-45cbc68e188b@baylibre.com> <CAAOTY_-wEzu6JavEAyRo8njOLRMq3i3wEcemNsuMaK00W9QqpQ@mail.gmail.com>
In-Reply-To: <CAAOTY_-wEzu6JavEAyRo8njOLRMq3i3wEcemNsuMaK00W9QqpQ@mail.gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 15 Mar 2023 10:35:57 +0100
Message-ID: <CAFGrd9pa3c3eZcuGg7AmHL8kOAkyx96hwjwnMuO-G9BR1ORJ_w@mail.gmail.com>
Subject: Re: [PATCH 19/21] drm/mediatek: dpi: add support for dpi clock
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Le lun. 13 mars 2023 =C3=A0 16:21, Chun-Kuang Hu <chunkuang.hu@kernel.org> =
a =C3=A9crit :
>
> >
> > +       dpi->dpi_clk =3D devm_clk_get_optional(dev, "dpi");
>
> For MT8365, DPI clock is not optional, so make sure that MT8365 DPI
> should have this clock.

This should be check and notified at build time thanks to the
device-tree binding. Do you prefer this?:
#IF MT8365_SOC
    dpi->dpi_clk =3D devm_clk_get(dev, "dpi");

Regards,
Alex
