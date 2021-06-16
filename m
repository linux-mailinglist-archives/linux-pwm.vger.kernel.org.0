Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC033AA286
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jun 2021 19:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhFPRiX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Jun 2021 13:38:23 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:43796 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFPRiX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Jun 2021 13:38:23 -0400
Received: by mail-io1-f47.google.com with SMTP id k16so36763ios.10;
        Wed, 16 Jun 2021 10:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TfReIXMTwp6Wosahz5KJ03ZWH5KufcYPJieTN+6ZoGI=;
        b=ABJ6Xz6K1iXIg7VvdLJRa70JXbmr0wAfKjYt5YLWMreAzEdMxrwJhZUl+5a7kBrzJ8
         Hklm4RSVL5M7aagOfleYSMlvysk/pV6KmQYGD2oAH9TZmx5rW+UP6XoDhItW1PqDm6Xy
         znHA7ici8cYalLd/3BF6DMtWLJHD+TeC9MVd4dyW+sSMAdKIMZswb4MJBjs3botJCGbS
         q4YGujTVhlU3EIDDy7UEQO5DXfr9uhOl0Buws5oRNMJ7JobkUdB71W6CiTex19nTv2GV
         FrdIr5Yrs8lOIsNOvHIJNLohdcHysL5fu9sCQUZPD0NCoMD5lTCIhkEgY7CSLctwQDzk
         FUYQ==
X-Gm-Message-State: AOAM532r9aPtSIXr/OKz0rXm9AU9fSgJZZL73mhlJDVKYGSL7hLUeCmK
        j31QrlSghvFLTvpBnp/7QQ==
X-Google-Smtp-Source: ABdhPJzaDFiall/i+w/dGWGtd2jNAELajz46QfPpazJtdzBYMxSeUliL7uUhMnNXXv/5pNQv37atcg==
X-Received: by 2002:a05:6602:15cb:: with SMTP id f11mr438857iow.108.1623864976729;
        Wed, 16 Jun 2021 10:36:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o14sm1461531ilq.85.2021.06.16.10.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 10:36:16 -0700 (PDT)
Received: (nullmailer pid 3589220 invoked by uid 1000);
        Wed, 16 Jun 2021 17:36:14 -0000
Date:   Wed, 16 Jun 2021 11:36:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: Use examples with documented/matching
 schema
Message-ID: <20210616173614.GA3589188@robh.at.kernel.org>
References: <20210608215834.2236920-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608215834.2236920-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 08 Jun 2021 22:58:34 +0100, Sudeep Holla wrote:
> 'nvidia,tegra20-pwm' is not yet documented in the YAML schema. Use
> 'allwinner,sun7i-a20-pwm' instead to get rid of the following warning
> with 'make DT_CHECKER_FLAGS=-m dt_binding_check':
> 
> 	pwm/pwm.example.dt.yaml:0:0: /example-0/pwm@7000a000: failed to match
> 	any schema with compatible: ['nvidia,tegra20-pwm']
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.yaml | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Applied, thanks!
