Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34FD5223FA
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 20:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348918AbiEJS3t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 May 2022 14:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244905AbiEJS3q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2022 14:29:46 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B91238D59;
        Tue, 10 May 2022 11:29:45 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id i66so6918390oia.11;
        Tue, 10 May 2022 11:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8SoyxN+FrrEw5gq5dzBV/CjPfUWLivZhUTW1vpbidYI=;
        b=5UiG4i6T3Jlza1BIDKFTLY4fCR2WS7ul42oc+CBzT9auTS50jSXd2JEZNogAN+Gfhp
         hrLe+9A75+3Am8MD1v5PxEuuBcORhTfwtOD1kpzF5r3JBqfakER5KnN97VeeiygpCgjE
         VKDeLFsV/t5OUtcvH1Ds+J6R/+DRLVGZtt7bt/Iq+quTCd6waOoJx1wNIxQ8nkmqJGw9
         Zgdd487RnQh1ij4e1Hc74bJUJhG6m+sPgO3rfX+eA2RpI6kP/TMtM+p8ANQ9YOpV8GYO
         7jHbdpUyMNfnf5ukMYiblGmLqN4em6QiRXaaXNQys2TTzVbhowl2z37twOD2Q9yoSEQZ
         5N9A==
X-Gm-Message-State: AOAM531U/Bb5Q4YrbWmPmXTq1Zev83Bop9WVcTmDOvwZYwSK4RLo+MzI
        qe2lWrDMu2peXqUZAtiIrA==
X-Google-Smtp-Source: ABdhPJw5ifXMLkY+0j1uPR3RR8lgYZNXwQsm8XngoZo7q8URrMdZtksrquWNx04NC6D04ouKibv1SA==
X-Received: by 2002:a05:6808:2198:b0:326:8121:5ac4 with SMTP id be24-20020a056808219800b0032681215ac4mr679268oib.207.1652207384895;
        Tue, 10 May 2022 11:29:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m33-20020a056870562100b000edf80be4ecsm5768088oao.58.2022.05.10.11.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:29:44 -0700 (PDT)
Received: (nullmailer pid 2349262 invoked by uid 1000);
        Tue, 10 May 2022 18:29:43 -0000
Date:   Tue, 10 May 2022 13:29:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC 3/8] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poeg-group property
Message-ID: <YnqvF8DeAUlXP8NV@robh.at.kernel.org>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
 <20220510151112.16249-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510151112.16249-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 10 May 2022 16:11:07 +0100, Biju Das wrote:
> For output disable operation, POEG group needs to be linked with
> GPT. Document renesas,poeg-group property for linking both GPT and
> POEG devices.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
