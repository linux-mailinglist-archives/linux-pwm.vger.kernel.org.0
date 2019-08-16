Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56D909EB
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2019 23:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfHPVCJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Aug 2019 17:02:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40379 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPVCI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Aug 2019 17:02:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id c34so10829519otb.7;
        Fri, 16 Aug 2019 14:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZFxKR576aWu66XIGODf4Dfqh9pMbrp3cn6HjNum0x/A=;
        b=lkQ7a7EEws2eTQsn87CRGSqBxNIYRGijVCfv+nXWBlVB1i5ZkHkoyZNvXI/LAqVfcI
         N/IuDJOLFK+l6HhmQ1SIhMePndOH6Bpy7nZ0WgBuoZIuwnN8QfxLzydj1WIWJx+PL1FV
         5zc/kxb9UL7LOQRD31PoO3URHoJXF8erRmyIPuMWev0i89w9ju2cm8PGnC+JvQkosk/2
         IMBM+ht+yZUn97PU8RVdsGNQg2IB13oa3732CgU8IxYUlWd+OgCrwmegkDFhgO9UlOx3
         olBXzIV1hKxNEZI4/usd1l9brAglRKmoD4dwrBS9tqx3gvclkFtsEmXChKqWeh2dNqMV
         uzfQ==
X-Gm-Message-State: APjAAAUGpE7sOgMp7eb7+U5Fxe7j9txFMDnTPtf9HZhEpB4APRnNPxH1
        ZPZpUuCqbsfjy4Xdl9o7LA==
X-Google-Smtp-Source: APXvYqx2dK3twuUktSJd04/r2aF5V2tGmUhKOx7YAFKtnfAaGx9f/qJ8sIFYoDauwR1vMrY5vHRb/A==
X-Received: by 2002:a9d:590b:: with SMTP id t11mr9386551oth.239.1565989327722;
        Fri, 16 Aug 2019 14:02:07 -0700 (PDT)
Received: from localhost (ip-173-126-47-137.ftwttx.spcsdns.net. [173.126.47.137])
        by smtp.gmail.com with ESMTPSA id 11sm2590891otc.45.2019.08.16.14.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:02:07 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:02:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH v3 7/10] dt-bindings: pwm: update bindings for MT7629 SoC
Message-ID: <20190816210205.GA23351@bogus>
References: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
 <1565940088-845-8-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565940088-845-8-git-send-email-sam.shih@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 16 Aug 2019 15:21:25 +0800, Sam Shih wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> This updates bindings for MT7629 pwm controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
