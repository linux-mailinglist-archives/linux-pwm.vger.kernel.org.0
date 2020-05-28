Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9F1E542C
	for <lists+linux-pwm@lfdr.de>; Thu, 28 May 2020 04:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgE1Crk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 May 2020 22:47:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37234 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1Crj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 May 2020 22:47:39 -0400
Received: by mail-io1-f68.google.com with SMTP id r2so18085930ioo.4;
        Wed, 27 May 2020 19:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HErFQ3RihllwszLmK+bWoBbNtup3wq0O9RJIVYu56bk=;
        b=ONqHW5zqu7yDaOI/5Ydzn2LVhuT5wYigy7GXJQsKILDRbpRpuQMi4DuW7Og0FphCga
         BGZMK0WE57xSg7rTR/Cp6F/PW6xwGBV05tUGp6F0Eqnfpd31smjMou7II8bTXc43qYiD
         /JnRynbwpy6vI6NBPsGKcEnsMdbZuHxJdeUx2JUgUbt4LNkG1X66XCMY6Oz/B5RtSUNR
         OsoRf5P1a5aOCJTdo3JpjUD92aaN/UQrIN2gjj4510SCUp4tM2kOYYARflTCh3qxytqd
         mA4pJc4zXp4nExLeGBtXd/pSCRN4vbV0EZ8+vZxUscIATfe+0lwxdo2VEMr4xA6rygr2
         +TMA==
X-Gm-Message-State: AOAM533/GtBYLVewtJdWujLIjSWsU41YwcWvO1402Dq8MydRz46C1O38
        +U0ccucg7nv4uquQ1vUQ0w==
X-Google-Smtp-Source: ABdhPJx4bm9u6LggKI+6fECbJDz/YJWEON9xWm3kqPJIGl0Su7EEcGhPGAvdlhTNnzMeVYeiVrJZ/w==
X-Received: by 2002:a02:cc56:: with SMTP id i22mr805809jaq.31.1590634058471;
        Wed, 27 May 2020 19:47:38 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f15sm2537695ill.58.2020.05.27.19.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:47:37 -0700 (PDT)
Received: (nullmailer pid 3268998 invoked by uid 1000);
        Thu, 28 May 2020 02:47:37 -0000
Date:   Wed, 27 May 2020 20:47:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     p.zabel@pengutronix.de, thierry.reding@gmail.com,
        shawnguo@kernel.org, linux-pwm@vger.kernel.org, robh+dt@kernel.org,
        festevam@gmail.com, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Convert imx pwm to json-schema
Message-ID: <20200528024737.GA3268948@bogus>
References: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 14 May 2020 14:54:18 +0800, Anson Huang wrote:
> Convert the imx pwm binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt  | 27 ---------
>  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 66 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/imx-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> 

Applied, thanks!
