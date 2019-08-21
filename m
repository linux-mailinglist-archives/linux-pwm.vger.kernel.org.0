Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98393983B6
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Aug 2019 20:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfHUSxz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Aug 2019 14:53:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46253 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfHUSxz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Aug 2019 14:53:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so3017952otk.13;
        Wed, 21 Aug 2019 11:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iY3AiGAh74iBv32YB3Wm5qEpYXVEPqk770y2+LBrvMk=;
        b=nfGb9CWvYmhTp65tUEj3a/nmjTcPh+rtl7XDyNxsSqDnqJ8n59aL+PV5d6bpfyoWI7
         OOu5DCp+4AyXi3idq1RIY2r+CLoxlVYeh6nSzwEHBvEqJ3eYpoedH3WxJ4GTBSr2tTj3
         g65mAbVBap+8odetihp9WBUBsKzLZ8b9b1SKkkOtObLguZq+/UG4J3RB/4OQD7kCeAh3
         GOikWQt7h9Gpv0lMOC0Csm1DqEq8wS+JptOtIIcyjSnba8aoxPcTd/vlG0MPEbaQIG8C
         vkOaQwVtUBc5s9HBwUPLobR9q2buqTvPuZk02X8eekslk+xqvdWk7OMjsooznnwJiCl5
         UrIg==
X-Gm-Message-State: APjAAAV+G0BMslgsxC/OEyds5/APYOulbGtBPxXt244rYt2TGum62DQ/
        Rn6STE7/3Ve3iaUz1TURnw==
X-Google-Smtp-Source: APXvYqzuCn8jJD6kzc356GuGt6qLtAZth9pfedf18zFxYFHQ+LLdzv1MrFWlMTPRzvhmjn7loz7L2w==
X-Received: by 2002:a9d:5a11:: with SMTP id v17mr26358857oth.87.1566413634446;
        Wed, 21 Aug 2019 11:53:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u5sm6352377oic.45.2019.08.21.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:53:54 -0700 (PDT)
Date:   Wed, 21 Aug 2019 13:53:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: pwm-mediatek: Add documentation
 for MT8516
Message-ID: <20190821185353.GA29669@bogus>
References: <20190805125848.15751-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805125848.15751-1-fparent@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon,  5 Aug 2019 14:58:47 +0200, Fabien Parent wrote:
> Add the device-tree documentation for the PWM IP on the MediaTek
> MT8516 SoCs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
