Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F37B7ABAF5
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Sep 2023 23:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjIVVRq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Sep 2023 17:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjIVVRp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Sep 2023 17:17:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469DE8
        for <linux-pwm@vger.kernel.org>; Fri, 22 Sep 2023 14:17:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD6CC433C8;
        Fri, 22 Sep 2023 21:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695417459;
        bh=Si8g+TFji3EHeLWTCrwxT+KxSVzn8oTXYkKRkhBHtfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9lwbitVfe2UTFqrcwaLcOkCoWPDhRaIhrRBKesWMrrHTfR6MoqdoRbFMKQ/M0QUU
         vH0Je9qjsGtxwMkVedQm2lcCZeGdTq6wfvGMen5vjv4FKRH9NB/8RH8wOnGJGGRXd7
         MTQAJ96DFF+qR5+1GDBXSYvPEtods62rksmvzf8M/1KdogFQpAYzomFeVDdsUcMBlf
         0Zsr0kkFWNY9cQS8QRafspEImWqYApXp/HTeCqJ5Yy1L+ERZ9gqHviJPIWjUy1E5og
         uXw7RoHS9edmHDMfpzHI1MKLZgqQeDPfSbwrGZl3G/aoUGTbqLtTnyLMwLdsko1mSx
         jLS6sOzrP+VNg==
Received: (nullmailer pid 3633302 invoked by uid 1000);
        Fri, 22 Sep 2023 21:17:37 -0000
Date:   Fri, 22 Sep 2023 16:17:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>, thierry.reding@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 3/3] dt-bindings: pwm: mxs: Allow passing #pwm-cells = <2>
Message-ID: <20230922211737.GA3628801-robh@kernel.org>
References: <20230921184348.290261-1-festevam@gmail.com>
 <20230921184348.290261-3-festevam@gmail.com>
 <20230921195909.ulpoqvrixocwqou2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230921195909.ulpoqvrixocwqou2@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 21, 2023 at 09:59:09PM +0200, Uwe Kleine-König wrote:
> Hello Fabio,
> 
> On Thu, Sep 21, 2023 at 03:43:48PM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <festevam@denx.de>
> > 
> > All the in-tree imx23 and imx28 devicetrees use #pwm-cells = <2>.
> > 
> > Allow it in the schema to avoid warnings.
> > 
> > It is still possible for a devicetree to pass the third cell with the
> > PWM polarity though.
> > 
> > This is similar to imx-pwm.yaml that allows #pwm-cells to be 2 or 3.
> 
> Alternatively switch all devicetrees to use = <3>? That's what I'd
> prefer given that the PWM supports both polarities.

Technically, that could break older clients predating 3 cell support. 
But maybe that's far back enough now to not care. Either way,

Acked-by: Rob Herring <robh@kernel.org>
