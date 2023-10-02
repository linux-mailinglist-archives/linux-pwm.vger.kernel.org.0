Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931697B4B47
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Oct 2023 08:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjJBGBP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Oct 2023 02:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJBGBO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Oct 2023 02:01:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8AF9B
        for <linux-pwm@vger.kernel.org>; Sun,  1 Oct 2023 23:01:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63A5C433C7;
        Mon,  2 Oct 2023 06:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696226471;
        bh=E6NHbvDfGdEjlAdElIutkw57ebLwqlv15g3KdfcOOkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQsl1SOg6VvHVmF2WorijKzYYoHySmQfhTjFt5JMVeDMSmrQUW+cXUoQ3+PIvK8Iy
         WppASh9kUzu1zWraN2/yKG2p+or5mOTelAHptdhBoPD8AP6NahHPQJsXf9QoO8A2mT
         S4JLIxsC1iSqa4ctMspx3+Rpq78x2mwjdf6KZsfmsymjh8s394B9d8Q641fhlc/xi5
         fgLt0F7vr+1We5/M8pifL5CVXORf298G3od2B6caozSC2405gqES4IYFlzsBtamoQx
         kIy3yxL1cZ9HKAES3oGWXfw032IYhreGALrJXGfwOWJENTJvUE0FeavcdMhFAb/05d
         UJMlZ6H5l4cbA==
Date:   Mon, 2 Oct 2023 06:01:08 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH 11/11] pwm: cros-ec: Simplify using devm_pwmchip_add()
 and dev_err_probe()
Message-ID: <ZRpcpPhCX95ks2rc@google.com>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
 <20230929161918.2410424-12-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929161918.2410424-12-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Sep 29, 2023 at 06:19:18PM +0200, Uwe Kleine-König wrote:
> Using devm_pwmchip_add() allows to drop pwmchip_remove() from the remove
> function which makes this function empty. Then there is no user of
> drvdata left and platform_set_drvdata() can be dropped, too.
> 
> Further simplify and improve error returning using dev_err_probe().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
