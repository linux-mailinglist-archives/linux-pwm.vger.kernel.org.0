Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECF6525BC
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Dec 2022 18:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiLTRrp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Dec 2022 12:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiLTRrm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Dec 2022 12:47:42 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED721AA23;
        Tue, 20 Dec 2022 09:47:41 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-14455716674so16253039fac.7;
        Tue, 20 Dec 2022 09:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfCS79n0Ope3GY0870xoipOwOe/J2aLH9i5SYl522FE=;
        b=x1aJKV6gUj7AZm8tQGRUpdoGZ1D80hWfb1+JKGljnMsHZMXXhtMOUL153umY+0gpBW
         R4Zh+d0L19qItRO9hcIKRBzH5oy0ykB+sfgq8XyiSHgJBIPlpSmE8zNV4qPlttIMioXv
         Skbxmz2Gj0jX+aY61PjoEqdM2vGEJNL90NDuqu2CylOJ+Q/YwFIydfHmWJf8ZuNLCReY
         JwYd6GqLuQ+pW51RySwwVq1AeerGca5AUJAB8qcQcLiwikfiqu9EsA92VEA5teYtKO0C
         HPo61YjWwmfg4UhKqDh7muXWKavo1jjdCSaVwQoF7clS5BDnFXy55E2+g8OSp5ZoejOG
         U5Lg==
X-Gm-Message-State: ANoB5pmbgFDhZdUCrIfHMHnmcFD37zu55F3H9RhfoeQCS+m23oWjSotx
        2M4O1WYrWZanoxirGWVgnA==
X-Google-Smtp-Source: AA0mqf64iDx1lopFZUDUmBrEBzAOsqDX1+vFNzrdWaZXU2GWUsH+0rYb+zpK/Vec64zkeov6pn6vvQ==
X-Received: by 2002:a05:6870:9a06:b0:144:840e:76be with SMTP id fo6-20020a0568709a0600b00144840e76bemr25465804oab.24.1671558460231;
        Tue, 20 Dec 2022 09:47:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b0013b911d5960sm6264244oac.49.2022.12.20.09.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:47:39 -0800 (PST)
Received: (nullmailer pid 807006 invoked by uid 1000);
        Tue, 20 Dec 2022 17:47:38 -0000
Date:   Tue, 20 Dec 2022 11:47:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [DO NOT APPLY PATCH v3 1/3] dt-bindings: pwm: Add RZ/G2L GPT
 binding
Message-ID: <20221220174738.GA800802-robh@kernel.org>
References: <20221215205843.4074504-1-biju.das.jz@bp.renesas.com>
 <20221215205843.4074504-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215205843.4074504-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Dec 15, 2022 at 08:58:41PM +0000, Biju Das wrote:
> Add device tree bindings for the General PWM Timer (GPT).
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  sending[1] to avoid bot error for the next patch.

Don't do that. The correct thing to do is note the dependency in the 
patch with the dependency (after '---'). The bot will read that and 
decide to not send a failure email to you. The bot doesn't read cover 
letters.

Rob
