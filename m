Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9604293FEA
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Oct 2020 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgJTPv1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Oct 2020 11:51:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37455 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731778AbgJTPv0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Oct 2020 11:51:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id m22so2157285ots.4;
        Tue, 20 Oct 2020 08:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o1jr+LQI3neSRU9mhYCD09x59Rl+accC5fl8cYRl988=;
        b=VMmnoJKZZxsGqnV7rkDxt9a38JBv4iYJmVDfUr4/AXgFVCnI5cyDH85I/cFK79zKtG
         0A9SQ7tzMV2TJAI1+J2JPguESjB1r7p/pnNdEtCBbozdU5eVM9BV64AfnOmoqJeyrRM7
         0LUVxk5TDUL6O+llZqAv0du4omImyyTdcc934fZZDZM5g4JATwy64KpHVu8fnvVqzgyH
         sU5YKWe8bUdS3GXj5YzERu0s1CtF1EfLKPVLVpi/dsYaIvblkaJ3XUc+45c/EKv3qGsd
         wtwX33uQzNQbBXnFpS4ILMleoGd6zE1jFo0fTmGSjKA6mg+pRHXWX3Fud2G4IvFLOIzD
         endw==
X-Gm-Message-State: AOAM532wDvQLPkTa3fxvxk94k3XXiEM0Ilwj9LbsDmlo3X9PBBY6sA74
        1MwKeSnRXA5nRjYgySywrg==
X-Google-Smtp-Source: ABdhPJwIPVQjNT4eoEaO6m8h+vP/uedjDFiu4iNmJ6LRBgqch0MXCCZDzVdfmG/vYdMynGceRFkrrA==
X-Received: by 2002:a9d:65c7:: with SMTP id z7mr2227576oth.327.1603209086026;
        Tue, 20 Oct 2020 08:51:26 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u186sm621259oia.51.2020.10.20.08.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:51:25 -0700 (PDT)
Received: (nullmailer pid 904828 invoked by uid 1000);
        Tue, 20 Oct 2020 15:51:24 -0000
Date:   Tue, 20 Oct 2020 10:51:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     vijayakannan.ayyathurai@intel.com
Cc:     wan.ahmad.zainie.wan.mohamad@intel.com,
        lakshmi.bai.raja.subramanian@intel.com, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com
Subject: Re: [PATCH v13 2/2] dt-bindings: pwm: keembay: Add bindings for
 Intel Keem Bay PWM
Message-ID: <20201020155124.GA904484@bogus>
References: <cover.1603127898.git.vijayakannan.ayyathurai@intel.com>
 <48f86a9a525701cfc61e3375d1d6f65ce38a9b26.1603127898.git.vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48f86a9a525701cfc61e3375d1d6f65ce38a9b26.1603127898.git.vijayakannan.ayyathurai@intel.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 20 Oct 2020 01:28:47 +0800, vijayakannan.ayyathurai@intel.com wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> 
> Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> 
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> ---
>  .../bindings/pwm/intel,keembay-pwm.yaml       | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

