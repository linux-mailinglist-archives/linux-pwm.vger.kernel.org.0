Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B974E8AA41
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Aug 2019 00:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHLWPP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 18:15:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33889 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHLWPO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 18:15:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so165101775otk.1;
        Mon, 12 Aug 2019 15:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Hl8Ot2aSHBMEKcD9YMEz708iweSmdqsv8l8Mi9vl6U=;
        b=hJ5aZ2OuwrVPr36Y8BEuHlqMTyM2wzHmmKUgUyZPusvXdVvynDP1bpV6WCwWammJVy
         LPVO0EZ/tuYcWi31HBHsFHu+ODGG3F0nFArgUfpFKeSWqHZdlqbJuBwOQT0W3x2AIRhw
         9bSDxaTefY2E5md4eu4lT0GkEpr6YhJMm4Y+hOPnMAkXhOPam/YRxrGx5eMhUlXhqIuh
         oMLzLqMzdRcHBhBCiLMYwxl5+C7kXLSE8y9lftBBjI95Ozmgocx/oXNMbXQL7yrskXkF
         ikYFo1QMsubTcoPUQCiTwM+OGOPiPXDkcsrBof/mZ+16MlbLIKlyKoKV1S8WP4XZMkvG
         M2sA==
X-Gm-Message-State: APjAAAWyoKdJNezBiDglqVpNjYGhAykxXhAlL6x4qTO4DExXDtgT7u9G
        5MDbLwrSngVpB1mqiEwstQ==
X-Google-Smtp-Source: APXvYqxITl4/8wD2qF1OX3crvab5FCfVn+l0zPlE0D/ekVjf18e2o5f8bw/6PsZEPiWUQhTL3E0zOg==
X-Received: by 2002:a02:c996:: with SMTP id b22mr16399239jap.39.1565648113681;
        Mon, 12 Aug 2019 15:15:13 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id w23sm90581004ioa.51.2019.08.12.15.15.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:15:13 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:15:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH wn 3/4] dt-bindings: display: panel: add auo
 kd101n80-45na panel bindings
Message-ID: <20190812221512.GA24378@bogus>
References: <20190811091001.49555-1-jitao.shi@mediatek.com>
 <20190811091001.49555-4-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811091001.49555-4-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 11 Aug 2019 17:10:00 +0800, Jitao Shi wrote:
> Add documentation for auo kd101n80-45na panel.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/auo,kd101n80-45na.txt       | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
