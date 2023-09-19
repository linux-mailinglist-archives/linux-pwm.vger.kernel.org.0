Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17037A6293
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Sep 2023 14:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjISMTH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Sep 2023 08:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjISMSz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Sep 2023 08:18:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A27CEC
        for <linux-pwm@vger.kernel.org>; Tue, 19 Sep 2023 05:17:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C589C433C8;
        Tue, 19 Sep 2023 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695125851;
        bh=AnY+CRdTGMGEGBw97rD9S5slAnh6NrSxJZWh8YteEN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsvuI5WV35+sEZ0Hq0/0DAXkkx3zWAssNZMJE479GqaSA9NY0dRiq3TizNPv93mtT
         R4CFLDr96PAE0d+aMlXDyJDkZHWUVKXy+fN4R9HdGkb7BLFCje8xKlxt/UjBaVcL20
         uaJHBIVSLY+YZ4apULZGmNu/hC2DtIDYYIghUE9KVOHq/GXSX3YTiYK2L2l3LbAVkn
         U7luWtoKbzhxRAifjoi/sZDFuVO1cNJb89ZQ27jZrcZi8+GUzyu8DyuTk3hAIq9C2g
         3MiDLJ5CLmMGP7AXDUUxqqH6kghdTGMatgOCBrdUNW9wJknyH84wQDc0M9KVsC+7ez
         CeZ29kTEM7EAw==
Date:   Tue, 19 Sep 2023 14:17:24 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8qxp: add adma_pwm in adma
Message-ID: <20230919121723.GB11740@T480>
References: <20230424082108.26512-1-alexander.stein@ew.tq-group.com>
 <20230424082108.26512-2-alexander.stein@ew.tq-group.com>
 <20230604095038.GA4199@dragon>
 <8261600.T7Z3S40VBb@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8261600.T7Z3S40VBb@steina-w>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 17, 2023 at 10:03:20AM +0200, Alexander Stein wrote:
> Hi Shawn,
> 
> Am Sonntag, 4. Juni 2023, 11:50:38 CEST schrieb Shawn Guo:
> > On Mon, Apr 24, 2023 at 10:21:08AM +0200, Alexander Stein wrote:
> > > Add PWM device and the corresponding clock gating device in adma
> > > subsystem.
> > > 
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > 
> > Looks good to me.  I will pick it up after dt-bindings one gets
> > accepted/picked first.
> 
> Did this get missed accidentally? Patch 1 was picked by Thierry already.

Sorry, indeed!

Applied, thanks!

Shawn
