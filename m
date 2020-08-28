Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D7125629E
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Aug 2020 23:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgH1Vuw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Aug 2020 17:50:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33912 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1Vuv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2020 17:50:51 -0400
Received: by mail-io1-f68.google.com with SMTP id w20so561803iom.1;
        Fri, 28 Aug 2020 14:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0roQvlk2we8ViOmNkNlFjgs4mr1pn/4U547TOwbQwGs=;
        b=DZZg7NJ+53iQW0JOPTDSiLzrc2w76KFlnEAnqMU8MVI6XXM1+ptGjaYOCbyR6mZv4A
         I1BZ804GU6Z3j++6Mr45kBJ7GpbVpTQpsIMMv147sbVuu1LY/BZukbwjPhYa2YbkjEsw
         oOFoeiEq6xggitJ09ZNWds7RWvXrz6YP9O/qaIm90yEswTsIxWlKvH9c7YkpI2jbmPfB
         AuQZ+T9/hUpQhPOMACRG9FhUveBg064W+OVRo+Xkjnd/durH5wVedq6bbYV5PLovjG61
         uqpqccOPRYqcTWoieiuV4KxsS/TS8E0B5p+Ahdx4BZ3ILne72VMfFKC1A84flU2W/2tf
         XWdA==
X-Gm-Message-State: AOAM532Ib/zRwgQot5CPLb7f6RlLGN4jD/TLt9XqCkOu0DNU5DyrgT3p
        3DFMhWhS13WJo2WpSO/j+w==
X-Google-Smtp-Source: ABdhPJzrJi7is5WkCexaCeFBszVQDb9yHUjlIsPgQHlrp3pBr97/6Ei066osxzBoBKHpBO/xjq6zoQ==
X-Received: by 2002:a05:6638:a9a:: with SMTP id 26mr3111326jas.21.1598651450494;
        Fri, 28 Aug 2020 14:50:50 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id p7sm289507ilj.56.2020.08.28.14.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 14:50:49 -0700 (PDT)
Received: (nullmailer pid 3466509 invoked by uid 1000);
        Fri, 28 Aug 2020 21:50:47 -0000
Date:   Fri, 28 Aug 2020 15:50:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     robh+dt@kernel.org, u.kleine-koenig@pengutronix.de,
        andriy.shevchenko@intel.com, rahul.tanwar.linux@gmail.com,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, qi-ming.wu@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, rtanwar@maxlinear.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 1/2] Add DT bindings YAML schema for PWM fan
 controller of LGM SoC
Message-ID: <20200828215047.GA3466454@bogus>
References: <cover.1598331849.git.rahul.tanwar@linux.intel.com>
 <cb86a768550b592b5fc4713bd07689bf84ba044b.1598331849.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb86a768550b592b5fc4713bd07689bf84ba044b.1598331849.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 25 Aug 2020 13:07:05 +0800, Rahul Tanwar wrote:
> Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
> which is only used to control the fan attached to the system. This
> PWM controller does not have any other consumer other than fan.
> Add DT bindings documentation for this PWM fan controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
