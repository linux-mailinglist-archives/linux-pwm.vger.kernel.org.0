Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE47F0E30
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Nov 2023 09:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjKTIzB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Nov 2023 03:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjKTIy5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Nov 2023 03:54:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD945A2
        for <linux-pwm@vger.kernel.org>; Mon, 20 Nov 2023 00:54:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DADEC433C9;
        Mon, 20 Nov 2023 08:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700470493;
        bh=ngjDvUn9q+QedfoN11X78gSytnT4ehNNgoyO5WHwviA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOMDZPb7Dj7FPocPAfqmp66+k9MTZtRVQWUtHdTWU8hqJ6nLLwkxzEfjElB6Q6avq
         D4MzRj/S5kJP6sCeZUra7U8so/snekW2mH3bkfZjfdLxqsGt7zaZNoZtmdgzZcI/AW
         4xWcO0/0fpYnLr+eB5PVL9UpWyQF9rLrMwJUGk6yucj/27mFxjn5IyChMUayC9VgXo
         1Z5uwJEtfTvxz8yBHltPtBBNwPLn+gYV6cvQr3d/r1H28n4URLty1rvNCyTiGlgd5L
         b6RqhuRRRssF6ULs88Y9bkzFFxVVG4+1bAmcVXUYRNLpEeFV2b8LqZToVvJhD5iWZy
         ayBZjsRMZprEg==
Date:   Mon, 20 Nov 2023 16:54:50 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: cros-ec: Drop unused member from driver private data
Message-ID: <ZVse2h-qt6w08diL@google.com>
References: <20231116105212.650951-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231116105212.650951-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 16, 2023 at 11:52:13AM +0100, Uwe Kleine-König wrote:
> .dev is unused since the driver was introduced in commit 1f0d3bb02785
> ("pwm: Add ChromeOS EC PWM driver"). Drop it.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
