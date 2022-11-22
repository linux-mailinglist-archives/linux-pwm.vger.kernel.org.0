Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88A633DE9
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Nov 2022 14:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiKVNmF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Nov 2022 08:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiKVNmE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Nov 2022 08:42:04 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EFB7654C5;
        Tue, 22 Nov 2022 05:42:00 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 946C18061;
        Tue, 22 Nov 2022 13:31:45 +0000 (UTC)
Date:   Tue, 22 Nov 2022 15:41:58 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Allow decimal format in
 addition to hex format
Message-ID: <Y3zRpgY1cXCKsJCu@atomide.com>
References: <20221122123225.59106-1-tony@atomide.com>
 <20221122133825.d67q4q6k3wkncucj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122133825.d67q4q6k3wkncucj@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [221122 13:28]:
> On Tue, Nov 22, 2022 at 02:32:24PM +0200, Tony Lindgren wrote:
> > Let's allow node numbering in decimal format too.
> > 
> > Simple human-readable increments/IDs are usually decimal, hex is only for
> > addresses as noted by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>.
> > 
> > Let's use an improved match suggested by Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> and improved a bit by Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de>.
> > 
> > Cc: linux-pwm@vger.kernel.org
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Which tree should this merged through? The obvious candidates are pwm,
> dt and omap.

The dt folks usually queue the binding patches separately.

Regards,

Tony
