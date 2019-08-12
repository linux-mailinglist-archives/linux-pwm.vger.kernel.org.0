Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D02F8A9B2
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2019 23:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHLVvF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 17:51:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33788 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHLVvF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 17:51:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so11883330otl.0;
        Mon, 12 Aug 2019 14:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YxUrApdtPFyU9H97SktZgYuAmYUABRE+Th0JrfsEq/M=;
        b=lHs9nlY+uZmE73y2F7u9PZYHHIlSnhEJK38vmzR8RuPqfCy5wqM/da32UmByEUDFJ7
         LlmWew5gj0GjgMNaktoH9i36A4+ggtFB0rEiyf1nGAEwDnBoS0JTv5HAr0qkPotF+rYp
         BLJWp/FIAdUkvI6DqhTshUWiLprKOD4I+BMJGNZQ+gGVnGdoiGoi4Dd3GEKXe1ytZzC1
         CJDY8NG1iTNveTFO2z8jCGyN3o+F4JUAtvl6FIdsqU0A58KDpj7EFOuBbjNTK7KqxD/D
         fFMEgni7V506Gr1Bb8Oyyu84nFVm8XNLG+CxAEMPM5E8bOblcvMsSnFpHd08ScqGLvyM
         FFyA==
X-Gm-Message-State: APjAAAXj56qAjxk94PiTQkaGpSuvzncED74w54Q8H+18x2kmppa4wjUn
        57Hbe6GEIn4e/4ZUkoSITw==
X-Google-Smtp-Source: APXvYqwW5LyJN2JbS/NExdIgszJ6uaD2Tgi4uSs8FsNTdmrSvThlgJLvWGD+LXLQDLkz6CM2zEf6mw==
X-Received: by 2002:a02:528a:: with SMTP id d132mr38640289jab.68.1565646664461;
        Mon, 12 Aug 2019 14:51:04 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id a7sm83055927iok.19.2019.08.12.14.51.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 14:51:04 -0700 (PDT)
Date:   Mon, 12 Aug 2019 15:51:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [PATCH v5 1/4] dt-bindings: display: mediatek: update dpi
  supported chips
Message-ID: <20190812215103.GB5954@bogus>
References: <20190807060257.57007-1-jitao.shi@mediatek.com>
 <20190807060257.57007-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807060257.57007-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Aug 07, 2019 at 02:02:54PM +0800, Jitao Shi wrote:
> Add decriptions about supported chips, including MT2701 & MT8173 &
> mt8183
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.txt        | 11 +++++++++++
>  1 file changed, 11 insertions(+)

And run a current get_maintainers.pl. Your DT maintainer list is out of 
date by years.

Rob
