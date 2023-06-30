Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194AD7433C6
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jun 2023 06:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjF3Eyn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Jun 2023 00:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjF3Eym (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Jun 2023 00:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C818F268F
        for <linux-pwm@vger.kernel.org>; Thu, 29 Jun 2023 21:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E7EE6164B
        for <linux-pwm@vger.kernel.org>; Fri, 30 Jun 2023 04:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D53AC433C8;
        Fri, 30 Jun 2023 04:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688100880;
        bh=eoliOSaKGQAolA79oDzqjjwO5r3sAUMUdDNg2GHu2Sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOgRhFl+3XlQKNPz+wz2Y0Zk1Jc0K6SgOMpaMVUVPhozQ5IJ0CPRfqEAiwM7/aZO9
         sHVoCmMPFrjJqYKbraSY6Hm5xBNJV3Cw9Z2dYN3f4VskOIiH+yJiRxBbuGRv21FFIJ
         gVSnKg4hgIEvyjSaXj1rjHlNRUCtXB+64Q5jPL0hS1wsL0KmEcv7KgtFl1k+tL9xM4
         Upf5xZkvAANTxVOGr6yzcKE1FJcE+luSmkac+MyDXiFNJg81qoTJg9LsCn+QmuBP+F
         pKO081uOX3GYXnrRfiml4s3wVNMOophB/9dKRoQtC+QbYmsJRJ9JuSV8QQDF7QXGGQ
         0Kk0F6mgp7slA==
Date:   Fri, 30 Jun 2023 12:54:37 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH 7/8] pwm: cros-ec: Put per channel data into driver data
Message-ID: <ZJ5gDWlm38qYguyH@google.com>
References: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
 <20230629094839.757092-8-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230629094839.757092-8-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jun 29, 2023 at 11:48:38AM +0200, Uwe Kleine-König wrote:
> Instead of an allocation of a single u16 per channel, allocate them all
> in a single chunk which greatly reduces memory fragmentation and also
> the overhead to track the allocated memory. Also put the channel data in
> driver data where it's cheaper to determine the address (no function
> call involved, just a trivial pointer addition).
> 
> This also allows to get rid of the request and free callbacks.
> 
> The only cost is that the channel data is allocated early, and even for
> unused channels.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

With comments addressed below:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> @@ -27,6 +27,7 @@ struct cros_ec_pwm_device {
>  	struct cros_ec_device *ec;
>  	struct pwm_chip chip;
>  	bool use_pwm_type;
> +	struct cros_ec_pwm *channel;

Please update the kernel-doc too.  Otherwise:
$ ./scripts/kernel-doc -none drivers/pwm/pwm-cros-ec.c
drivers/pwm/pwm-cros-ec.c:31: warning: Function parameter or member 'channel'
not described in 'cros_ec_pwm_device'

I have no strong preference: please consider to use `channels` if it makes
sense.
