Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03F77120B2
	for <lists+linux-pwm@lfdr.de>; Fri, 26 May 2023 09:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbjEZHLU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 May 2023 03:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242184AbjEZHLT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 May 2023 03:11:19 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C1FB
        for <linux-pwm@vger.kernel.org>; Fri, 26 May 2023 00:11:13 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f6affdb6ddso4080661cf.0
        for <linux-pwm@vger.kernel.org>; Fri, 26 May 2023 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685085072; x=1687677072;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=GCXnf2r6VsBKAI5L0UXQTx3ZKJRfqkFUtVgaZCZ2CBuA9HK0KOrSIJ5pvj5CvLDqs9
         tkcnlKafAkiN9WhXOpNLOuG0FuV/bApPY5uYKFeBoGqi/fk/lE3TEKe6UV9KbefjVo5o
         pWuV3AVF4gJBQpLBZhhlWlF8+6smXyB4jnkHY5gJUr2ZgWJI6gP0Bxo2pF6/V54KSJeX
         AhC/j6PTxvhbC4l7UAZbq4iEezmxsbY9FjsRxY7ECn44HNLUWp8tpYpIvnvOfnQ6g2Os
         qARSxPuruSN7i0j7mKjC6I71ElsWIvJm6wlN5eQrstiT4ijInR2mhjFBekQyJcWOG2wE
         kJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685085072; x=1687677072;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=KzFcawy6B5XL9qMpGHo37k3Tob+EShlUD7xZ/SDqShC3Ml4tC3Y13zcO5wQSfH9dZJ
         mbT5J8HK9lpBtio3Al8h0dHpQ6tbVP4PvAMTHb5Cbv2xCtig2LLHmjf2EpvGgodpktM6
         aZiHW4PO18p4Hm+G+lxCEooDDoSGcks6jAu/8WNie6WhbhyBfzWkYBSQzIZl9ryhYVQl
         bg43Imrto58SXQ/LopAQXxTCPdwxn66UlTDlqIlUsrvG3jjgM+x7gz6iHb9xII/EMpb7
         23Ugu+jSzdrL+qDifIavlm2HfbToMAicjHrnVNv/iQ6kLynmTYXL1D5/pg7ict5xqmNU
         ++7w==
X-Gm-Message-State: AC+VfDw8rO7FltnZ5uJmdn9imNKl0yUkQL1eoXtmItJFQJiAfUoa7GdJ
        ROWJ+lir2ffcaz69N0nNgOqn9TvqCF/f2qgt2qs=
X-Google-Smtp-Source: ACHHUZ5z8fhXalYwExjOCENeg/xJ6mERyzrZ5AZUx+YFz/zZbvcPfCTFBvlXZRQxJz/T3JVMVjAd5l0E9EoL0e2npss=
X-Received: by 2002:a05:622a:1047:b0:3f6:b95e:f700 with SMTP id
 f7-20020a05622a104700b003f6b95ef700mr831582qte.57.1685085071759; Fri, 26 May
 2023 00:11:11 -0700 (PDT)
MIME-Version: 1.0
Sender: fataoouedraogo65@gmail.com
Received: by 2002:a05:622a:38e:b0:3f6:b025:c0b5 with HTTP; Fri, 26 May 2023
 00:11:11 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Fri, 26 May 2023 00:11:11 -0700
X-Google-Sender-Auth: Phwi4pSMI9VAOny-QmSnMBjhStU
Message-ID: <CALAg1jQtfNjaTimpKmUGnoBSqQ+o9YrkCZ63tdzWJ+Nsb79Jow@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
