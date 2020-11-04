Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ACE2A707F
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Nov 2020 23:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgKDWaD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 17:30:03 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42232 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgKDWaD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 17:30:03 -0500
Received: by mail-ot1-f65.google.com with SMTP id h62so260658oth.9;
        Wed, 04 Nov 2020 14:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ZkVCQbSXTNZ9Qi1DnAuirobnBBpCwpdqEzoZru1nj4=;
        b=Fj5fWXNx/+0eNZZtIy0bHpMqGurM39D/VxOFC6d/A+UyjjEOHd3hUo2MyYarvANZ9i
         7z9u0bEdGdA+PVCQgJU5jUY1KvRqbXdQ5Am3Z9/EIhep2HVCYSYPOVDt79Gvi2LDwqyL
         wWX5cLT0HMRdGCObHsAvoGe48eFR65gyclPVPQqMQ5VLb+ISRCo+3et7qMsKSR8Vj3u+
         +PnwlFKRogmCF+vMcwurCxCLcoYeC9FriO3t0Ejk93v1B3cMgpRXFKbtRc/zrdjD+IyN
         btFEp0RFHn8QuXvH2dkieCgH++uRw0hIIUjEYdRyg28qfTPabtj+dCMO+URzmoZfGpIB
         w52Q==
X-Gm-Message-State: AOAM5301j3RfbeUJukzLHJaggEzPcIiSAkqGwSVsB30o59H0XALeipqQ
        3XG6ypCq67rI3Ww2wh0MPlmShCSyew==
X-Google-Smtp-Source: ABdhPJz+4MjZAIDXSqmWPn0xChkuuMaBHm1yjjCVVmO699h/BlUMoUFpSwjTCKqed72Y6otnOC14SQ==
X-Received: by 2002:a9d:27e8:: with SMTP id c95mr2025257otb.262.1604529001977;
        Wed, 04 Nov 2020 14:30:01 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s189sm793792oig.46.2020.11.04.14.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 14:30:01 -0800 (PST)
Received: (nullmailer pid 42132 invoked by uid 1000);
        Wed, 04 Nov 2020 22:30:00 -0000
Date:   Wed, 4 Nov 2020 16:30:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: microchip: atmel, at91rm9200-tcb:
 add atmel, tcb-pwm
Message-ID: <20201104223000.GA42098@bogus>
References: <20201030183658.1007395-1-alexandre.belloni@bootlin.com>
 <20201030183658.1007395-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030183658.1007395-2-alexandre.belloni@bootlin.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 30 Oct 2020 19:36:55 +0100, Alexandre Belloni wrote:
> Move the TCB pwm nodes under their parent. This removes the need for the
> tc-block property as there is now a child-parent relationship between the
> TC channel and the TC block.
> 
> Move the documentation to the main file.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Changes in v2:
>  - rework commit message
>  - use enum for the pwm node reg values as suggested by Rob.
> 
>  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt | 16 ---------
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 34 ++++++++++++++++++-
>  2 files changed, 33 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
