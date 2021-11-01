Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCF4441DA6
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Nov 2021 17:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhKAQDk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Nov 2021 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhKAQDj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Nov 2021 12:03:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FFCC061714;
        Mon,  1 Nov 2021 09:01:06 -0700 (PDT)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F1C5D929;
        Mon,  1 Nov 2021 17:01:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1635782462;
        bh=5ZWAoKLlZZuY65KZd730bdFnSI5mAthLW0u8x8WX3Zk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Mn0VzVEdlbrBmuMSFmPP76nVenUVXv8cc/LcwHWTXApXBF9VW8ToU3xzIk0VnVvLa
         4sp+SvnzrQhbPPiDQv1IPB2wBMpTnBvHNSREGBC7Ls1DqrVYXhh9T2wWsojI/7Nkfw
         K05c/oW9J4HycMOKfrlLKkbfiIBQTMIYCxkKBkK4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <622e5ac9a841e874f772e0d9d200200706914dac.1635337701.git.geert+renesas@glider.be>
References: <622e5ac9a841e874f772e0d9d200200706914dac.1635337701.git.geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car M3-W+ device tree bindings
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Mon, 01 Nov 2021 16:00:59 +0000
Message-ID: <163578245972.275423.7178542030126605980@Monstersaurus>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Quoting Geert Uytterhoeven (2021-10-27 13:29:22)
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Add device tree bindings for TPU found on R-Car M3-W+ SoCs.
>=20
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Having just seen this one looking through (the plentiful) ULCB+KF DT
warnings... I guess I don't need to submit a patch.

Thanks,

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b=
/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> index 0171a04257b808e7..1f5c6384182e013a 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> @@ -35,6 +35,7 @@ properties:
>            - renesas,tpu-r8a7794   # R-Car E2
>            - renesas,tpu-r8a7795   # R-Car H3
>            - renesas,tpu-r8a7796   # R-Car M3-W
> +          - renesas,tpu-r8a77961  # R-Car M3-W+
>            - renesas,tpu-r8a77965  # R-Car M3-N
>            - renesas,tpu-r8a77970  # R-Car V3M
>            - renesas,tpu-r8a77980  # R-Car V3H
> --=20
> 2.25.1
>
