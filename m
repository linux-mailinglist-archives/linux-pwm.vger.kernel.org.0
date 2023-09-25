Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978C87ADCE3
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Sep 2023 18:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjIYQQ1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Sep 2023 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjIYQQ1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Sep 2023 12:16:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E092FF
        for <linux-pwm@vger.kernel.org>; Mon, 25 Sep 2023 09:16:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405C3C433C7;
        Mon, 25 Sep 2023 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695658580;
        bh=TSyaUNxgQTernA9NMaDm994uOAqgq7TwhlPvqJNX9tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQIUUdtnqJxUmd+MPxkwZ5E09md3C49i97ZEg0rttza330Jv3NkZRNDUXUPq5jhkt
         ucNA96Lu+jZgYhbhXhXaj2PN9y0sN/ZpmHlYXMEHEKzV92G/oS0MyPI0DNHfpwqy6N
         o9WLN9Qb3iTT5RWWEshwe+v11XUiFCV77WoXLFf76O3QgtBzBCUFtKdDI9DGB3doAw
         PWoyjkDKI2t5WU7VZX7c3+fkT3nfirEmtN8T8EsWsVVfMYfh2ry7PL4gAR5k3QjU2c
         An89XAVSHhp9mHWxc2JrCWS/m1nxCKOJrHb225uGPN3zG2yUtsuY29zZGyH/UPx8q1
         aqUIN5j0Vv3xA==
Received: (nullmailer pid 1458119 invoked by uid 1000);
        Mon, 25 Sep 2023 16:16:18 -0000
Date:   Mon, 25 Sep 2023 11:16:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, shawnguo@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        Fabio Estevam <festevam@denx.de>,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: mxs: Document fsl,imx28-pwm
Message-ID: <169565857661.1457958.3485561553574114610.robh@kernel.org>
References: <20230922124229.359543-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922124229.359543-1-festevam@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Fri, 22 Sep 2023 09:42:27 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> imx28 uses the same PWM block that is found on imx23.
> 
> Add an entry for fsl,imx28-pwm.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v1:
> - None. Only collected Uwe's ack.
> 
>  Documentation/devicetree/bindings/pwm/mxs-pwm.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

