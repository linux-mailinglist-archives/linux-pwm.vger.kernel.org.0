Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A837E2D18BD
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 19:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgLGSvX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 13:51:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45949 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGSvX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 13:51:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id h18so9489542otq.12;
        Mon, 07 Dec 2020 10:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3qQx9rj3Y0jkw8xAvThQpwnEPjDqjhVsbJkOLpjJJc=;
        b=J5sAs0iPnwduXtt8gVqoQGnpS1GJc60xfLpqQt/ujR51KumjpeMwT/mMBR5NE7Bwew
         Qv1Im85nl0qUC+IqeOXnV0D00ig8+hRax53trJ3N843U23mhMpyNu1XOhgDE2mIej0Vx
         Ag6FySiD3iirsSmW4YXOhLPhJpIryLFK29b4KUp5AAwmpVyt3oyvYh7Ce1bE5VivWv0E
         +ax1FXjyvheQZm/+l5+txHoe+1r8oJtS1NlU33FiOsFy9HDLRSObgfysDF0t7YrtMaZC
         qq8JBPKBYlVK4Ach+easC5Ih6ZRYFEJ4+flFh/Jj4JaYOgdVGT6i055n5yRZDdxPfIcP
         18bw==
X-Gm-Message-State: AOAM530jvgvHr69r0SnzvG2Nq6EebzB1FMj/5HWGju4jdqEvvId7TMGX
        I8mYjvFh7rMbAHxJnDuWyA==
X-Google-Smtp-Source: ABdhPJy7fUQkjZ27/+CvPE6JMuQeGK4TS6bKhx4NonPnb1Xi7LrsTBLGZE1a9ODMufitoxPUeLcTuQ==
X-Received: by 2002:a9d:774a:: with SMTP id t10mr3132445otl.190.1607367041980;
        Mon, 07 Dec 2020 10:50:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p1sm2840721oto.4.2020.12.07.10.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 10:50:41 -0800 (PST)
Received: (nullmailer pid 608789 invoked by uid 1000);
        Mon, 07 Dec 2020 18:50:40 -0000
Date:   Mon, 7 Dec 2020 12:50:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: pca9685: add staggered-outputs property
Message-ID: <20201207185040.GA608113@robh.at.kernel.org>
References: <20201112163931.204243-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112163931.204243-1-clemens.gruber@pqgruber.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 12, 2020 at 05:39:31PM +0100, Clemens Gruber wrote:
> The pca9685 driver supports a new staggered-outputs property for reduced
> current surges and EMI. This adds documentation for the new DT property.
> 
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
> index f21b55c95738..911bbb65984e 100644
> --- a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
> @@ -12,6 +12,8 @@ Optional properties:
>    - invert (bool): boolean to enable inverted logic
>    - open-drain (bool): boolean to configure outputs with open-drain structure;
>  		       if omitted use totem-pole structure
> +  - staggered-outputs (bool): boolean to enable staggered output ON times to
> +			      minimize current surges and EMI

Needs a vendor prefix.

>  
>  Example:
>  
> -- 
> 2.29.2
> 
