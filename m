Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC56363E7FB
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 03:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLAClj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 21:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLACli (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 21:41:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4D292A12
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 18:41:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CDE7B81D17
        for <linux-pwm@vger.kernel.org>; Thu,  1 Dec 2022 02:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB51C433D7;
        Thu,  1 Dec 2022 02:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669862494;
        bh=kQz0+HFGrtKeoRxgeRsrcDdIbIuMKBAN+HJXhL+YDtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rrs9y+bTAbbO6cz8wALB0IgVIV/wElGRRxR5D/om7JFpS6dMGBMhA4WZbmnW/zlJI
         /qmjDxsit77tn1c2LxAg6aBXETyXClxhc0I4YeBSGy3lwaQBiab1HBfQurckTF88S4
         t6iCkCB8s+sGIWHw06IgeU4UhzijAlOk3I9ryPinWL73dHizcO5q8OHVaPMewEfQQo
         1bX59jtyYNwJz/Lf8X14gmFqVObaoc0Wg8d9yrBzg+WE1NSLReps+xmV2B+hkCzkCx
         AiXRF4Lu3m0OVImOX/reMCxn88o4bl0HLUz5UE98qola0OiCquIawUnZ0fqvvzd0wY
         kJHp3xqgF+tHg==
Date:   Thu, 1 Dec 2022 10:41:31 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 06/11] pwm: cros-ec: Propagate errors in .get_state()
 to the caller
Message-ID: <Y4gUW3imlkugimQE@google.com>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130152148.2769768-7-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 30, 2022 at 04:21:43PM +0100, Uwe Kleine-König wrote:
> .get_state() can return an error indication. Make use of it to propagate
> failing hardware accesses.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
