Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EE6298DD1
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Oct 2020 14:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770353AbgJZN1g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Oct 2020 09:27:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34109 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770342AbgJZN1f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Oct 2020 09:27:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id k3so7386549otp.1;
        Mon, 26 Oct 2020 06:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dICAa5zihRqkfMFzmU2zbHT9Gkg7gGmUMAo66qHLtrs=;
        b=oJ5b3I09ASxMC1a4S/wEdbOgSnhfskK2c0FyONvdKwramL46iNLKkMk8XWmhNXyX0a
         WsWbesxVUFotNcmBr1G+djTct+vZJeWJyiQfKuvaBZqJc7UwWllNM4O/Nal+bapdGF8z
         f2Gy3u6zNK9iaNO5KNwGPN/XgBPsMRGek9tis3bytyIkEPMbU/65Za9bmHx7Tz1oGUiQ
         hiH6674Xnxrmm1p0QCXeSOsv7K4eD0WIkIyfPb0HshIOoSHtSeSjDegkBQI/BdNQyS9m
         RrVoUnk9n9xr+rKy9qhnVMJJ87C1bP3JuG0N8DlP0E28q/2T9SwtQJlbsxoSgZqthniG
         Bbpg==
X-Gm-Message-State: AOAM533WIn8xubU1lG21YYH1oZiezHa7uB399LMJL/447QEsnSu7jkG7
        t1/IbfIb35Sg9APWEGsf8wa5BkObOQ==
X-Google-Smtp-Source: ABdhPJzB7uZlU7aojvgwdRg+bswvuVs94ivjynutrDsKpFzPNHbjZFMSqkJiWvL1Z9l//D7tryYCNA==
X-Received: by 2002:a9d:822:: with SMTP id 31mr13921986oty.224.1603718852758;
        Mon, 26 Oct 2020 06:27:32 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l44sm3924052ooi.44.2020.10.26.06.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:27:31 -0700 (PDT)
Received: (nullmailer pid 29159 invoked by uid 1000);
        Mon, 26 Oct 2020 13:27:31 -0000
Date:   Mon, 26 Oct 2020 08:27:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     matthias.bgg@gmail.com, thierry.reding@gmail.com,
        linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pwm: mtk-disp: add MT8167 SoC binding
Message-ID: <20201026132731.GA29104@bogus>
References: <20201016185015.3371433-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016185015.3371433-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 16 Oct 2020 20:50:15 +0200, Fabien Parent wrote:
> Add binding for MT8167 SoC. The IP is compatible with MT8173.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
