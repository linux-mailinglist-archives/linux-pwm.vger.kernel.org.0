Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D227ACECA
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Sep 2023 05:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjIYDwi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Sep 2023 23:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjIYDwi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 Sep 2023 23:52:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA085FC
        for <linux-pwm@vger.kernel.org>; Sun, 24 Sep 2023 20:52:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69CDC433C8;
        Mon, 25 Sep 2023 03:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695613951;
        bh=iMhuI+K7irijA4GtinLI4ZJTkWq6Q/oCEucRRY4fIzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNgsRMjJhGhFHd8mT9vaR3MDB7HdVwHi5DbgJNzp8UlwFsn/I9YMKIZGzeJxEJLab
         WrBSr3StiVA/60Ahttu+mK+AofbCYdXBrkTwgSxPxf2I+VxCU9kUFo/0n07frJgzWA
         jaxLYr3/y2jJmZA11TYV4gnyPk/ZZAD319pfAzVkGd2+e4MwLLKWRRqIRMyqlwYZUW
         1uXb8R/w1ERlyjZGvKl0/qizd7GLurTL8NBUhXGCTnqa43BXXPYhrCuYugjS8m29Jn
         U6rQPuO6PdNgkLr6oQUYTI6+5cwB+BkF2zpeLpwqWlPOD6OOecOmoGr52/TebgDHRX
         y9qk/nwvhqxUA==
Date:   Mon, 25 Sep 2023 11:52:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v2 3/3] ARM: dts: mxs: Switch to #pwm-cells = <3>
Message-ID: <20230925035221.GM7231@dragon>
References: <20230922124229.359543-1-festevam@gmail.com>
 <20230922124229.359543-3-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922124229.359543-3-festevam@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Sep 22, 2023 at 09:42:29AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> mxs-pwm.yaml documents that #pwm-cells should be 3.
> 
> This is correct as the last cell may indicate the PWM polarity.
> 
> Convert all mxs devicetree files to using #pwm-cells = <3> for
> consistency.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks!
