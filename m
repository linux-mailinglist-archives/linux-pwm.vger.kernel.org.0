Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF62A272B
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Aug 2019 21:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfH2TRl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Aug 2019 15:17:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35205 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfH2TRk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Aug 2019 15:17:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id 100so4577831otn.2;
        Thu, 29 Aug 2019 12:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lUNDK8okeaG+StRZk49PqR3pb3KxBcvMlQlvR84IJuE=;
        b=ehf/DbFk4yML96oksiNfly7f62LvWHGkOo0smPSnNijZS+IlH+kEoBS1q0o1rCrmYK
         HlhqO+xmO5w4vbjy+3id41xiExaFcxtB83AyoMB1xNfizUEz9Iwl/FFKkdg1LYWz7k0W
         93ih1zZPT7NHCWVzQg4CKFpgkzKAns4j1V0FJXWR2u2+KFBctM6Ch6Yj8qt9F6dgFkiE
         HowlseeGRhe9MSGi8ffCbZbix8zlVtRn0iP4xf3hXDU0jp05ynypO/1WXim/tUbOCoDD
         JJ+QcnMxdX7Sr7nyRkhnqruMzd9OpS5Ro6YAjNiM9IcSiAbHILDcrFeGWDZqc8n33nrS
         WkAA==
X-Gm-Message-State: APjAAAXXFxz7tqSE1Y8ErhuaLqRmneDtDx2278XoZBPhblv56BhtvwRE
        c2t7Yirxeul4dSwT9ih++g==
X-Google-Smtp-Source: APXvYqwjleFRjcjRc0Auu8E/bMXkfJn6aIIX5yibCMAZNhu85rTpuRR7DK/sUMIDH60M3OWn/+ol1Q==
X-Received: by 2002:a9d:4717:: with SMTP id a23mr8773212otf.212.1567106259689;
        Thu, 29 Aug 2019 12:17:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c15sm1106792otf.35.2019.08.29.12.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 12:17:39 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:17:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v6 10/11] dt-bindings: pwm: update bindings for MT7629 SoC
Message-ID: <20190829191738.GA17395@bogus>
References: <1567057160-552-1-git-send-email-sam.shih@mediatek.com>
 <1567057160-552-11-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567057160-552-11-git-send-email-sam.shih@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 29, 2019 at 01:39:19PM +0800, Sam Shih wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> This updates bindings for MT7629 pwm controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> Changes since v1:
> - add a Reviewed-by tag

I believe you missed mine.

> 
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index ea95b490a913..c7bd5633d1eb 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -6,6 +6,7 @@ Required properties:
>     - "mediatek,mt7622-pwm": found on mt7622 SoC.
>     - "mediatek,mt7623-pwm": found on mt7623 SoC.
>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
> +   - "mediatek,mt7629-pwm", "mediatek,mt7622-pwm": found on mt7629 SoC.
>   - reg: physical base address and length of the controller's registers.
>   - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
>     the cell format.
> -- 
> 2.17.1
> 
