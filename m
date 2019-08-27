Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60FD99F276
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Aug 2019 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfH0Sjb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Aug 2019 14:39:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41943 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbfH0Sja (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Aug 2019 14:39:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so134404ota.8;
        Tue, 27 Aug 2019 11:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XMfpx8zaYFv8FB4sdyqjlN5h9P+ymLOJHIBXDCz83lw=;
        b=RM3iTfg94Sp11I7dq9Cb0WBP8TJ5XRBib4cii0Mypj+gvMfJLFd2T+tqEzKDFEqlwu
         znl+oY7YP02WAyXiSB9D0rzj32ZA1pOx8XZpF2jW1ABWJb8LAl5NVzel22XSeSnG9Sz4
         fQD+sWcQdCdTG4b5nsIGQzjRd+AtZLkr343KWbrx/2i5bHOLRTJGskNREcoaldH4G57V
         Wu3pV3tNBxTl7603iU/3UeeMuZDKd8HUan0vWzZ6aeQi9GMdLBEByOtrrIgwpHBOqiF3
         Cu13ynDH0NcNrVajRhanlpzjWb0r6e8G8xPHsG3jgiV+1TL1u/jIcbbL26HoU68829sF
         mcBg==
X-Gm-Message-State: APjAAAWMbGTWk6oNvozJt8XTs4nhf+pLcHzw7TovELpVO6j6JFKiCMXF
        M2AeJ1j8dVLUVVyTqNdSqw==
X-Google-Smtp-Source: APXvYqzoemcNCPbstiXM/G8dfEnWRe5MtRuqF2QfOKr+DAg0PvZiCXcrcG6fxo8TiaEvdRGl8Ab2hg==
X-Received: by 2002:a9d:170b:: with SMTP id i11mr40703ota.60.1566931169589;
        Tue, 27 Aug 2019 11:39:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z16sm3966oic.10.2019.08.27.11.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 11:39:25 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:39:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 07/13] dt-bindings: pwm: add a property "num-pwms"
Message-ID: <20190827183924.GA24178@bogus>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
 <1566457123-20791-8-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566457123-20791-8-git-send-email-sam.shih@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 22, 2019 at 02:58:37PM +0800, Sam Shih wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>

The subject should indicate this is for Mediatek.

> 
> This adds a property "num-pwms" in example so that we could
> specify the number of PWM channels via device tree.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v5:
> - Add an Acked-by tag
> - This file is original v4 patch 5/10
> (https://patchwork.kernel.org/patch/11102577/)
> 
> Change-Id: I429048afeffa96f3f14533910efe242f88776043
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index 991728cb46cb..ea95b490a913 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -14,12 +14,12 @@ Required properties:
>                  has no clocks
>     - "top": the top clock generator
>     - "main": clock used by the PWM core
> -   - "pwm1-8": the eight per PWM clocks for mt2712
> -   - "pwm1-6": the six per PWM clocks for mt7622
> -   - "pwm1-5": the five per PWM clocks for mt7623
> +   - "pwm1-N": the PWM clocks for each channel
> +   where N starting from 1 to the maximum number of PWM channels

Once converted to schema, you are going to be back to listing them out.

>   - pinctrl-names: Must contain a "default" entry.
>   - pinctrl-0: One property must exist for each entry in pinctrl-names.
>     See pinctrl/pinctrl-bindings.txt for details of the property values.
> + - num-pwms: the number of PWM channels.

You can't add new required properties without breaking compatibility. 

You already have to imply the number of channels from the compatible (or 
number of clocks) and you have to keep doing so to maintain 
compatibility, so why not just keep doing that for new chips?

Rob
