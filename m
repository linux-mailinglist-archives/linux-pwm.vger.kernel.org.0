Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77EE1D7AE6
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 16:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgEROSp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 10:18:45 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:32821 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROSo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 10:18:44 -0400
Received: by mail-il1-f194.google.com with SMTP id o67so5327766ila.0;
        Mon, 18 May 2020 07:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hnYbcDiYIwRZpK5nxVRVHqZ/c+O+PvlmAbbpRYWtFzY=;
        b=Hd7R652AVaV2gwozb5ELGFyvAECB4pwp5GbuEQhcEv/kmbIUDw+CZIyyiQDXOO6fvd
         +dI8BLOgud35WJlgGDxzc0QnctY7yP6E4yvZIWeQO80wPBoFg7K3iH2K+OiYRVulVjZ/
         QejyB01n/lHBObruVapr//ifeQ9U+qIpR/6oKtrNobUqHyxI7x+7kQzmnS8yt6DAwyNm
         irP4JsxyCLWP7sEepoM18hzCLQ6YvaWbazhHYXNUUh0ofbuQuW0a7bfura2aBaqaPITg
         aV26bywYfH9wB/0kd//+CCHMqxC0BPmoUdHWGCKfU+Nf1embCil1FgbRA8ETVO4DPWhu
         rPpQ==
X-Gm-Message-State: AOAM530j/b6srS8KcgQk8bikhZlM3LpjfaLTF3MXAERe+lEmCf3GaYnX
        w/Xfv6eI3TSO6e0TeL6Lkw==
X-Google-Smtp-Source: ABdhPJw2jhVb59il54p7l9FO5I6xjlCWG0g+rmAafwg+mWPaUxQsMLNZEfXGxrK1AecUdVSQe1gXyQ==
X-Received: by 2002:a92:2a09:: with SMTP id r9mr15979239ile.103.1589811523682;
        Mon, 18 May 2020 07:18:43 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 137sm3929056iob.32.2020.05.18.07.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:18:43 -0700 (PDT)
Received: (nullmailer pid 4792 invoked by uid 1000);
        Mon, 18 May 2020 14:18:42 -0000
Date:   Mon, 18 May 2020 08:18:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     devicetree@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        wan.ahmad.zainie.wan.mohamad@intel.com, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com,
        thierry.reding@gmail.com
Subject: Re: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Message-ID: <20200518141842.GA3594@bogus>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 17 May 2020 21:52:40 +0800,  wrote:
> From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
> 
> Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> 
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> ---
>  .../devicetree/bindings/pwm/pwm-keembay.yaml       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/pwm/pwm-keembay.example.dts:22.31-32 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:312: recipe for target 'Documentation/devicetree/bindings/pwm/pwm-keembay.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/pwm/pwm-keembay.example.dt.yaml] Error 1
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1292157

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

