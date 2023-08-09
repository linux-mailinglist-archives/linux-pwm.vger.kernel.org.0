Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F727761F7
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Aug 2023 16:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjHIOC4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 9 Aug 2023 10:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjHIOCz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Aug 2023 10:02:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B05819A1;
        Wed,  9 Aug 2023 07:02:53 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qTjlq-0007Tp-Tt; Wed, 09 Aug 2023 16:02:42 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@edgeble.ai>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: pwm: rockchip: Document rv1126-pwm
Date:   Wed, 09 Aug 2023 16:02:42 +0200
Message-ID: <5533260.88bMQJbFj6@phil>
In-Reply-To: <20230731145129.mrrkb6tcuvlpmxan@pengutronix.de>
References: <20230731103518.2906147-1-jagan@edgeble.ai>
 <20230731103518.2906147-2-jagan@edgeble.ai>
 <20230731145129.mrrkb6tcuvlpmxan@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am Montag, 31. Juli 2023, 16:51:29 CEST schrieb Uwe Kleine-König:
> On Mon, Jul 31, 2023 at 04:05:06PM +0530, Jagan Teki wrote:
> > Document pwm compatible for rv1126 which is fallback compatible
> > of rk3328-pwm group.
> > 
> > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Should this go in via the pwm tree, or together with the other patches
> via rockchip?

I have no clue, sadly. I _can_ pick it up, but I guess that would
require an Ack from Thierry? Otherwise I guess we'll need to wait
for him.


Heiko


