Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E56672420C
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Jun 2023 14:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjFFM1w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Jun 2023 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjFFM1v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Jun 2023 08:27:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0606610C7
        for <linux-pwm@vger.kernel.org>; Tue,  6 Jun 2023 05:27:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so8099451a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 06 Jun 2023 05:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686054468; x=1688646468;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6L7ebmHSep7BhRPx756Bnk9wA5QJEyDZvI3tM5IjJw=;
        b=jQuJuqsjyMN9Ir8YR7rH2lZY4CIpzB3RqkXHMjYW1GZJa8ivbXlpJfgf/kyGt+q/Hu
         sqqxCyD3mBMhrFNTPnSLlYjXJ/rDN7+YhLhn3j5bfvww8OUljuCo2JuFB8qXypkHsvXB
         zsV8iJYOBFiqOslSNWP/VSE5B0SOiXc9Ms+fEO4yDIhySEEZaq85733FJF1gDEJqmosq
         XSfgNmnyTCXCK6ZLy7vimoVdc26cRke21j/fpz/T5RQ6hyiyowusjNLpmQNjCdE1YPGE
         G4MonjsgjLBxVofrXkqqw6+f4i/Yc9AfWVecX3QcBjVydY0ASzL58LEuHxeK2aW5xEiH
         8qCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054468; x=1688646468;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6L7ebmHSep7BhRPx756Bnk9wA5QJEyDZvI3tM5IjJw=;
        b=jf/wOSKU56UfcCAXBwtBSQDLON4siDc4/MRrI8gDgS8ds00k/4mbrw3Hck8TIhQ9pO
         d+M5E02DkgBuqekoCN4FI8xvdB84KJgSBkynNjrN2zDt1XuFdcgUrHNXch2Ugv1oOfyF
         t9N9cwRHLFaEUiRU9xqosGhDFT0KnER5PlIuonHXz5UPFeRaDGicZrG/A3RIKv+PRk67
         Mx+SfaCwDOnif2GC9DtrIqqvgDHSnseAlp7dAeCVbqZc6oCAviP3K9UICx1nBB2kmk6v
         3f9cB0IhBke8P3SSPFSr9cz2KrH2Ag6O/530xDeFAwlnRhndS4wXR8axJwd6eHEwBL/7
         1H0w==
X-Gm-Message-State: AC+VfDym281nJXaZZRfKY89ZzC1hlWUVjknXYSJXCu5O38NeE90v6uHp
        38CKPRubSB7d1oXKaoaXS5hfYidLeEvWiWvKOrE=
X-Google-Smtp-Source: ACHHUZ7APQFarxoMIk3Jz6QpYHSrOuzjBop27ZGUUsZXNJsmULNvnvOeYIQ1M5FYkmiFrDCX0kyJA9ckx/vCfHk7cH8=
X-Received: by 2002:a17:907:360a:b0:978:6fbf:869c with SMTP id
 bk10-20020a170907360a00b009786fbf869cmr1724254ejc.16.1686054468200; Tue, 06
 Jun 2023 05:27:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: ashaalqaddfi10@gmail.com
Sender: aboudoulayekarambiri08@gmail.com
Received: by 2002:a17:906:9b88:b0:973:c47d:62e4 with HTTP; Tue, 6 Jun 2023
 05:27:47 -0700 (PDT)
From:   Aisha Gaddafi <ashaalqaddfi10@gmail.com>
Date:   Tue, 6 Jun 2023 05:27:47 -0700
X-Google-Sender-Auth: XkYX_b3LtZ0z55rgMPnXkSmtltI
Message-ID: <CANGHVWpea-W=+n6f5AC=m4UzC_Y6xKu33=FX9gyutrviBYSWJQ@mail.gmail.com>
Subject: Hello My Beloved One,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,
        MILLION_USD,MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:533 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9908]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ashaalqaddfi10[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aboudoulayekarambiri08[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ashaalqaddfi10[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.9 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.1 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello My Beloved One,

I came across your e-mail contact prior to a private search
while in need of your assistance. I am Aisha Al-Qaddafi, the only
biological Daughter of Former President of Libya Muammar   Al-Qaddafi.
Am a single Mother

and a Widow with three Children. I have investment funds worth Twenty
Seven Million Five Hundred Thousand United State Dollar (27.500.000.00
) and i need a trusted investment Manager/Partner because of my
current refugee status, however, I am interested in you for investment
project assistance in your country,

Maybe from there we can build business relationships in the near
future. I am willing to negotiate an investment/business profit
sharing ratio with you based on the future investment earning profits.
If you are willing to handle this project on my behalf kindly reply
urgently to enable me to provide you more information about the
investment funds.
Best Regards
