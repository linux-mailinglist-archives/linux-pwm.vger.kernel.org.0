Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BFE96839
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 20:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfHTSAS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Aug 2019 14:00:18 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35932 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTSAS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Aug 2019 14:00:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id n1so2396090oic.3;
        Tue, 20 Aug 2019 11:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q1gvNC9FakNN70iNTlLfpOxXe43hETiV8DaUowjuk4k=;
        b=qUAMqzpRFw2L6Fcsm7gYUp4B9TblbORRvAuoXoQE1BkkuoBOoyXNJf+4xXYuOAcnI8
         o+cB5TwxHn4HNj+BfQT3P9HMdhcOyMq0n2lvho344G3jgP4bY+7RQNrmYByWw/RP1ayw
         bAMiHhiYHTFBmiLDvvic9bY1IitIvDmbjUr6+j7Mm2Z6423r4dxEXcO6bR6w/RsH0b1d
         eqXd9SwGaoI07VS/6WD1ixQrxnv7ws7Rw5ccVyOX/DEcpagKN/jKQPEAu4Ee2ag+JS04
         6M/jESB8tEMJf7PIuq7XFVw6sTtZUKmecpmISKm9od7AUz377ESTwCJ6D0+ANn4cLQFF
         JOxA==
X-Gm-Message-State: APjAAAXBUcbw/D2L43Yzbj71ylO9JI6hAvlCnZuudJtnBH+rZNasfdxw
        KCCV+TVpsUB3B3UeNA8hTQ==
X-Google-Smtp-Source: APXvYqwS6vfSL5GG6Hy6vUEP0afiI29iW09/eMOV/jj9QtbvAKZYhgHCM2xtDsPdntbHcHfBhRBbOg==
X-Received: by 2002:aca:3509:: with SMTP id c9mr900141oia.179.1566324016813;
        Tue, 20 Aug 2019 11:00:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o26sm6431165otl.34.2019.08.20.11.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 11:00:16 -0700 (PDT)
Date:   Tue, 20 Aug 2019 13:00:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH v4 9/10] dt-bindings: pwm: update bindings for MT7629 SoC
Message-ID: <20190820180015.GA12975@bogus>
References: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
 <1566265225-27452-10-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566265225-27452-10-git-send-email-sam.shih@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 20 Aug 2019 09:40:24 +0800, Sam Shih wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> This updates bindings for MT7629 pwm controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
