Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A01AA59A3
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 16:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfIBOnl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 10:43:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53536 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfIBOnl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 10:43:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id q19so6067855wmc.3;
        Mon, 02 Sep 2019 07:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iZLcdNS033cxSK0Fvg6MV+q8rh6JD3AHU1mNNgBVJpQ=;
        b=LEyT1WQyBOp6pEz6uwSiYjFL99BbFbIaJTSOXwSiIoX11EBxKOtAxZGuyHdLKRtCWT
         vHBk1Mcx8L/nHg/tZsMCN/I3NO1q/nm4O1BOTKmM3qzTD8II8gDw6rGQ20O5ma6hoybc
         uz4irnSjurKltAK6rMUFlhZfBjJ5ZUkEV4FImEF9Lb9KS9EhDGVzNpSU+aZPuClLTb9t
         nH+P9xUNi8gfVLRRowR63+h6vqzAz1Bg5xpLjfsH/pEQw33VzALk7jUxpZvGmXifZPSV
         po2f2Ie91f+qhtqlNnPPAvnlnaovGK4/fTtK1Np+DKtN3RtC8+beFd8TuPwiB2pTBqmw
         cQFw==
X-Gm-Message-State: APjAAAXaj+2UfUuB2Ul05YqbtAYGqOoiVzK0hVCGODfcdFmcfsh48RnA
        SnjcSzEpdRuMuzvVlp3Bng==
X-Google-Smtp-Source: APXvYqwxtxRib647UlHObm5LyGs/Ur8DIObbfrBfd03KY7R2uk+nMKra+8g2kZJ8KgljWasyIMoWRA==
X-Received: by 2002:a05:600c:23cd:: with SMTP id p13mr33723857wmb.86.1567435418805;
        Mon, 02 Sep 2019 07:43:38 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id q192sm3004661wme.23.2019.09.02.07.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:43:38 -0700 (PDT)
Date:   Mon, 2 Sep 2019 15:43:37 +0100
From:   Rob Herring <robh@kernel.org>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7 07/11] dt-bindings: pwm: pwm-mediatek: add a property
 "num-pwms"
Message-ID: <20190902144337.GA25200@bogus>
References: <1567137437-10041-1-git-send-email-sam.shih@mediatek.com>
 <1567137437-10041-8-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567137437-10041-8-git-send-email-sam.shih@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 30, 2019 at 11:57:13AM +0800, Sam Shih wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> This adds a property "num-pwms" in example so that we could
> specify the number of PWM channels via device tree.

Please respond to my questions on v5.

> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
