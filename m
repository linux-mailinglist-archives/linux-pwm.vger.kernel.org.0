Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599C446DB83
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Dec 2021 19:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbhLHSwK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Dec 2021 13:52:10 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:42752 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLHSwK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Dec 2021 13:52:10 -0500
Received: by mail-oi1-f176.google.com with SMTP id n66so5301944oia.9;
        Wed, 08 Dec 2021 10:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6YjhuViXtPXp3dsrpk4roLFD9TEKz0peQX8DFf+iFDo=;
        b=3VaPy+xKsOiTKrvybEeg0ngY0R4KPatIAh5vrAJ7ZURwXCQJR/GQUG7r0satxkY93f
         VO9Zmry8RiKYMYZaRLotiSGrqp0QxtqHdBZJTorw8YllilVAqUlyaTGTLT0graeAl8y7
         2SIblHzFvabpHxg78BbrVo1q6Nym/lxy9vynKNJXzUdIp79eMn7/rPpwXbLTqJvLxToi
         PNeJ+FYaxzNBalAaXiRplXZhMBumzHldDJ64rzZfGOYKEvq5aLVQwAdICgmCuNRDbOaU
         jsy3kIdzju9Rs1rzsEk8syUoAN8QV7I4p8l9vt6LQsgo7ZYE6mQTkJ8WlUB5RB5+JTQ7
         AxmA==
X-Gm-Message-State: AOAM532SEsLT/vRg4nedO44yc85KL+g1jUaiwtfw6vkO8UcLlOWvSWNi
        yHChYyg86V4IwMHlp3S4+A==
X-Google-Smtp-Source: ABdhPJzrH1ZX4zJrvvxGzDXPKiEehaJEepTh+YVYNkGXoRk/ABIfxTFRN/va9qN0UQ+aaMAy8FZ57w==
X-Received: by 2002:a54:480a:: with SMTP id j10mr1338294oij.34.1638989317740;
        Wed, 08 Dec 2021 10:48:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j5sm616267ots.68.2021.12.08.10.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 10:48:37 -0800 (PST)
Received: (nullmailer pid 133093 invoked by uid 1000);
        Wed, 08 Dec 2021 18:48:36 -0000
Date:   Wed, 8 Dec 2021 12:48:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: Avoid selecting schema on node name
 match
Message-ID: <YbD+BJFv0DhIKFdE@robh.at.kernel.org>
References: <20211207124855.399223-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207124855.399223-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Dec 07, 2021 at 01:48:55PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Currently any node whose name starts with the "pwm-" prefix will match
> this schema and in turn required the "#pwm-cells" property. Avoid this
> by marking the schema with select: false, therefore only activating the
> schema when directly included from a PWM controller schema file.

Pinctrl nodes? I'd rather change pin node names.

> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Rob,
> 
> I've seen this used in some other schema files, but wanted to
> double-check with you if this is the correct solution for this problem.

I suppose this is fine. This schema is just about pointless as each 
producer has to define #pwm-cells anyways.

Acked-by: Rob Herring <robh@kernel.org>

> 
> Thanks,
> Thierry
> 
>  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
> index 2effe6c0de6b..3c01f85029e5 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
> @@ -9,6 +9,8 @@ title: PWM controllers (providers)
>  maintainers:
>    - Thierry Reding <thierry.reding@gmail.com>
>  
> +select: false
> +
>  properties:
>    $nodename:
>      pattern: "^pwm(@.*|-[0-9a-f])*$"
> -- 
> 2.33.1
> 
> 
