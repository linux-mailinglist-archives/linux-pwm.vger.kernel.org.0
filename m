Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FB51AB1B1
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2020 21:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437387AbgDOT3k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Apr 2020 15:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437032AbgDOT3g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Apr 2020 15:29:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B49C061A10
        for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2020 12:29:36 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOniz-0007ev-Qa; Wed, 15 Apr 2020 21:29:29 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOniy-00028a-S7; Wed, 15 Apr 2020 21:29:28 +0200
Date:   Wed, 15 Apr 2020 21:29:28 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: Fix cros-ec-pwm example dtc 'reg'
 warning
Message-ID: <20200415192928.tjmh2m6a63lmnp3b@pengutronix.de>
References: <20200415182639.18534-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415182639.18534-1-robh@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Rob,

On Wed, Apr 15, 2020 at 01:26:39PM -0500, Rob Herring wrote:
> The example for the CrOS EC PWM is incomplete and now generates a dtc
> warning:
> 
> Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.example.dts:17.11-23.11:
> Warning (unit_address_vs_reg): /example-0/cros-ec@0: node has a unit name, but no reg or ranges property
> 
> Fixing this results in more warnings as a parent spi node is needed as
> well.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pwm/google,cros-ec-pwm.yaml        | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> index 24c217b76580..41ece1d85315 100644
> --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> @@ -31,10 +31,17 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    cros-ec@0 {
> -        compatible = "google,cros-ec-spi";
> -        cros_ec_pwm: ec-pwm {
> -            compatible = "google,cros-ec-pwm";
> -            #pwm-cells = <1>;
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        cros-ec@0 {
> +            compatible = "google,cros-ec-spi";
> +            reg = <0>;
> +
> +            cros_ec_pwm: ec-pwm {
> +                compatible = "google,cros-ec-pwm";
> +                #pwm-cells = <1>;
> +            };

Looks reasonable

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Is this supposed to go via the pwm tree, or do you apply yourself via a
device-tree tree?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
