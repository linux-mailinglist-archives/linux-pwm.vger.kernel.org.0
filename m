Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A08717078E
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2019 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfGVRjT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Jul 2019 13:39:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41693 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfGVRjS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Jul 2019 13:39:18 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so71613042ioj.8;
        Mon, 22 Jul 2019 10:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wjVlpYQpZUbO09orLG9AZ6U1/SPFAZfxcKpbcS0Hb5E=;
        b=FWyOqNxQHH7yho5+sxcTPAFyritixUoY/nXnHNostYsp18cwcctYEQk+a1vStNnnPZ
         a+mvCp7tDpE0/mG9WjqQnt6VUkFN2vxATdVPMRknLw5dPkHN83jHT6/fs1u7IYCSac2l
         yMclkySkffkugDl8nWKJskoLJsbk2znLfMfsw3aunc/THlxpRVIymyenv7Bkk70L4JhZ
         aSs9TSAXM0g4n/qHr1IkbmVshp6KoY8ziIU8vriDhnWeWDtikMphXRHJHPgdP7hKQ+15
         mTCwCCXaVOqlokSEKkRYVhFFQuvgjox2jLO1gDdGdJa2XfeeiTbvfaqBn0rjJhoDlkom
         yrBQ==
X-Gm-Message-State: APjAAAV/WY767og7vclfWdaa2khjyiSVHr4s3BWxpffaD/cyUhdACm7o
        tfZgC7zQgIIQACyVtCkmGw==
X-Google-Smtp-Source: APXvYqxApqbNIx0zyoWtwrvfuA/FYi/DJQeGo5LXD2cSKwEdYujoOCwjHXvKo/HVr55kQ3JiI42Arg==
X-Received: by 2002:a6b:7606:: with SMTP id g6mr11597267iom.288.1563817157557;
        Mon, 22 Jul 2019 10:39:17 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id z19sm52082738ioh.12.2019.07.22.10.39.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:39:16 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:39:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
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
Subject: Re: [v3 1/4] dt-bindngs: display: panel: Add BOE tv101wum-n16 panel
 bindings
Message-ID: <20190722173916.GA26308@bogus>
References: <20190626025400.109567-1-jitao.shi@mediatek.com>
 <20190626025400.109567-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626025400.109567-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 26 Jun 2019 10:53:57 +0800, Jitao Shi wrote:
> Add documentation for boe tv101wum-n16 panel.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../display/panel/boe,tv101wum-nl6.txt        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
